//
//  PulseViewController.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/23.
//

// https://github.com/athanasiospap/Pulse
import AVFoundation
import UIKit

class PulseViewController: UIViewController {
    @IBOutlet weak var previewLayerShadowView: UIView!
    @IBOutlet weak var previewLayer: UIView!
    @IBOutlet weak var pulseLabel: UILabel!
    @IBOutlet weak var thresholdLabel: UILabel!
    private var validFrameCounter = 0
    // TODO: 暫定対応で強制アンラップをしています
    private var heartRateManager: HeartRateManager!
    private var hueFilter = Filter()
    private var pulseDetector = PulseDetector()
    private var inputs: [CGFloat] = []
    private var measurementStartedFlag = false
    private var timer = Timer()

    init() {
        super.init(nibName: "PulseViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initVideoCapture()
        thresholdLabel.text = "バックカメラに赤色 🟥　になるまで指をあててください"
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupPreviewView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initCaptureSession()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deinitCaptureSession()
    }

    // MARK: - Setup Views
    private func setupPreviewView() {
        previewLayer.layer.cornerRadius = 12.0
        previewLayer.layer.masksToBounds = true
        previewLayer.backgroundColor = .red
        previewLayerShadowView.backgroundColor = .clear
        previewLayerShadowView.layer.shadowColor = UIColor.black.cgColor
        previewLayerShadowView.layer.shadowOpacity = 0.25
        previewLayerShadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        previewLayerShadowView.layer.shadowRadius = 3
        previewLayerShadowView.clipsToBounds = false
        view.backgroundColor = PrimaryUIColor.background
    }

    // MARK: - Frames Capture Methods
    private func initVideoCapture() {
        let specs = VideoSpec(fps: 30, size: CGSize(width: 300, height: 300))
        heartRateManager = HeartRateManager(
            cameraType: .back,
            preferredSpec: specs,
            previewContainer: previewLayer.layer
        )
        heartRateManager.imageBufferHandler = { [unowned self] imageBuffer in
            print("imageBuffer: ", imageBuffer)
            self.handle(buffer: imageBuffer)
        }
    }

    // MARK: - AVCaptureSession Helpers
    private func initCaptureSession() {
        heartRateManager.startCapture()
    }

    private func deinitCaptureSession() {
        heartRateManager.stopCapture()
        toggleTorch(status: false)
    }

    private func toggleTorch(status: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        device.toggleTorch(on: status)
    }

    // MARK: - Measurement
    private func startMeasurement() {
        DispatchQueue.main.async {
            self.toggleTorch(status: true)
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
                guard let self = self else { return }
                let average = self.pulseDetector.getAverage()
                let pulse = 60.0 / average
                if pulse == -60 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.pulseLabel.alpha = 0
                    }) { finished in
                        self.pulseLabel.isHidden = finished
                    }
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.pulseLabel.alpha = 1.0
                    }) { _ in
                        self.pulseLabel.isHidden = false
                        self.pulseLabel.text = "\(lroundf(pulse)) BPM"
                    }
                }
            })
        }
    }
}

extension PulseViewController {
    fileprivate func handle(buffer: CMSampleBuffer) {
        var redMean: CGFloat = 0.0
        var greenMean: CGFloat = 0.0
        var blueMean: CGFloat = 0.0
        let pixelBuffer = CMSampleBufferGetImageBuffer(buffer)
        // TODO: 暫定対応で強制アンラップをしています
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)
        let extent = cameraImage.extent
        let inputExtent = CIVector(
            x: extent.origin.x,
            y: extent.origin.y,
            z: extent.size.width,
            w: extent.size.height
        )
        let averageFileter = CIFilter(
            name: "CIAreaAverage",
            parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent]
        )!
        let outputImage = averageFileter.outputImage!
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(outputImage, from: outputImage.extent)!
        let rawData: NSData = cgImage.dataProvider!.data!
        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
        let bytes = UnsafeBufferPointer<UInt8>(start: pixels, count: rawData.length)
        var bgraIndex = 0
        for pixel in UnsafeBufferPointer(start: bytes.baseAddress, count: bytes.count) {
            switch bgraIndex {
            case 0:
                blueMean = CGFloat(pixel)
            case 1:
                greenMean = CGFloat(pixel)
            case 2:
                redMean = CGFloat(pixel)
            case 3:
                break
            default:
                break
            }
            bgraIndex += 1
        }
        let hsv = rgb2hsv((red: redMean, green: greenMean, blue: blueMean, alpha: 1.0))
        // Do a sanity check to see if a finger is placed over the camera
        if hsv.1 > 0.5 && hsv.2 > 0.5 {
            DispatchQueue.main.async {
                self.thresholdLabel.text = "人差し指 ☝️ をカメラに当てたまま待ってください"
                self.toggleTorch(status: true)
                if !self.measurementStartedFlag {
                    self.startMeasurement()
                    self.measurementStartedFlag = true
                }
            }
            validFrameCounter += 1
            inputs.append(hsv.0)
            // Filter the hue value - the filter is a simple BAND PASS FILTER that removes any DC component and any high frequency noise
            let filtered = hueFilter.processValue(value: Double(hsv.0))
            if validFrameCounter > 60 {
                self.pulseDetector.addNewValue(newVal: filtered, atTime: CACurrentMediaTime())
            }
        } else {
            validFrameCounter = 0
            measurementStartedFlag = false
            pulseDetector.reset()
            DispatchQueue.main.async {
                self.thresholdLabel.text = "バックカメラに赤色 🟥　になるまで指をあててください"
            }
        }
    }
}
