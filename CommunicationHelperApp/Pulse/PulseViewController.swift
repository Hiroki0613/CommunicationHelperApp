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
    var previewLayer = UIView()
    var pulseLabel = UILabel()
    var thresholdLabel = UILabel()
    private var validFrameCounter = 0
    // TODO: 暫定対応で強制アンラップをしています
    private var heartRateManager: HeartRateManager!
    private var hueFilter = Filter()
    private var pulseDetector = PulseDetector()
    private var inputs: [CGFloat] = []
    private var measurementStartedFlag = false
    private var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hirohiro_viewDidLoadスタート")
        initVideoCapture()
        thresholdLabel.text = "バックカメラに赤色 🟥　になるまで指をあててください"
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("hirohiro_viewWillLayoutSubviews")
        setupPreviewView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("hirohiro_viewWillAppearスタート")
        initCaptureSession()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("hirohiro_viewWillDisappear")
        deinitCaptureSession()
    }

    // MARK: - Setup Views
    private func setupPreviewView() {
        view.backgroundColor = .blue
        previewLayer.translatesAutoresizingMaskIntoConstraints = false
        pulseLabel.translatesAutoresizingMaskIntoConstraints = false
        thresholdLabel.translatesAutoresizingMaskIntoConstraints = false
        previewLayer.backgroundColor = .red
        view.addSubview(previewLayer)
        view.addSubview(pulseLabel)
        view.addSubview(thresholdLabel)
        NSLayoutConstraint.activate([
            previewLayer.widthAnchor.constraint(equalToConstant: 120),
            previewLayer.heightAnchor.constraint(equalToConstant: 120),
            previewLayer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            previewLayer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pulseLabel.topAnchor.constraint(equalTo: previewLayer.bottomAnchor, constant: 20),
            pulseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pulseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pulseLabel.heightAnchor.constraint(equalToConstant: 50),
            thresholdLabel.topAnchor.constraint(equalTo: pulseLabel.bottomAnchor, constant: 20),
            thresholdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            thresholdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            thresholdLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
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
            print("hirohiro_imageBuffer: ", imageBuffer)
            self.handle(buffer: imageBuffer)
        }
        print("hirohiro_viewDidLoadエンドエンド")
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
        print("hirohiro_toggleTorchです")
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
        print("hirohiro_viewWillAppearスタート1")
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
        print("hirohiro_viewWillAppearスタート2")
        let hsv = rgb2hsv((red: redMean, green: greenMean, blue: blueMean, alpha: 1.0))
        // Do a sanity check to see if a finger is placed over the camera
        print("hirohiro_viewDidLoadエンド__")
        if hsv.1 > 0.5 && hsv.2 > 0.5 {
            print("hirohiro_viewDidLoadエンド1")
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
            print("hirohiro_viewDidLoadエンド2")
            validFrameCounter = 0
            measurementStartedFlag = false
            pulseDetector.reset()
            DispatchQueue.main.async {
                self.thresholdLabel.text = "バックカメラに赤色 🟥　になるまで指をあててください"
            }
        }
    }
}
