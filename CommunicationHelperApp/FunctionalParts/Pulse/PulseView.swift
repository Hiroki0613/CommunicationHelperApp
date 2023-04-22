//
//  PulseView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/23.
//

// https://github.com/athanasiospap/Pulse
import AVFoundation
import SwiftUI
import UIKit

struct PulseView: UIViewControllerRepresentable {
    var messageText: String
    func makeUIViewController(context: Context) -> UIViewController {
        print("hirohiro_messageText: ", messageText)
        return PulseViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

//struct PulseViewView: UIViewRepresentable {
//    private var validFrameCounter = 0
//    var thresholdText = ""
//    var pulseText = ""
//    private var heartRateManager: HeartRateManager!
//    private var hueFilter = Filter()
//    private var pulseDetector = PulseDetector()
//    private var inputs: [CGFloat] = []
//    private var measurementStartedFlag = false
//    private var timer = Timer()
//
//    func makeUIView(context: Context) -> UIView {
//        var previewLayer = UIView()
//        previewLayer.layer.cornerRadius = 12.0
//        previewLayer.layer.masksToBounds = true
//        initVideoCapture(previewLayer: previewLayer)
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//    }
//
//    // MARK: - Frames Capture Methods
//    private mutating func initVideoCapture(previewLayer: UIView) {
//        let specs = VideoSpec(fps: 30, size: CGSize(width: 300, height: 300))
//        heartRateManager = HeartRateManager(
//            cameraType: .back,
//            preferredSpec: specs,
//            previewContainer: previewLayer.layer
//        )
//        heartRateManager.imageBufferHandler = { imageBuffer in
//            print("imageBuffer: ", imageBuffer)
//            self.handle(buffer: imageBuffer)
//        }
//    }
//
//    // MARK: - AVCaptureSession Helpers
//    private func initCaptureSession() {
//        heartRateManager.startCapture()
//    }
//
//    private func deinitCaptureSession() {
//        heartRateManager.stopCapture()
//        toggleTorch(status: false)
//    }
//
//    private func toggleTorch(status: Bool) {
//        guard let device = AVCaptureDevice.default(for: .video) else { return }
//        device.toggleTorch(on: status)
//    }
//
//    // MARK: - Measurement
//    private mutating func startMeasurement() {
//        DispatchQueue.main.async {
//            self.toggleTorch(status: true)
//            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
//                let average = self.pulseDetector.getAverage()
//                let pulse = 60.0 / average
//                if pulse == -60 {
//                    print("hirohiro_パルスがマイナス60になっています")
//
//                } else {
//                    pulseText = "\(lroundf(pulse))BPM"
//                }
//            })
//        }
//    }
//}
//
//extension PulseViewView {
//    fileprivate mutating func handle(buffer: CMSampleBuffer) {
//        var redMean: CGFloat = 0.0
//        var greenMean: CGFloat = 0.0
//        var blueMean: CGFloat = 0.0
//        let pixelBuffer = CMSampleBufferGetImageBuffer(buffer)
//        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)
//        let extent = cameraImage.extent
//        let inputExtent = CIVector(
//            x: extent.origin.x,
//            y: extent.origin.y,
//            z: extent.size.width,
//            w: extent.size.height
//        )
//        let averageFileter = CIFilter(
//            name: "CIAreaAverage",
//            parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent]
//        )!
//        let outputImage = averageFileter.outputImage!
//        let ctx = CIContext(options: nil)
//        let cgImage = ctx.createCGImage(outputImage, from: outputImage.extent)!
//        let rawData: NSData = cgImage.dataProvider!.data!
//        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
//        let bytes = UnsafeBufferPointer<UInt8>(start: pixels, count: rawData.length)
//        var bgraIndex = 0
//        for pixel in UnsafeBufferPointer(start: bytes.baseAddress, count: bytes.count) {
//            switch bgraIndex {
//            case 0:
//                blueMean = CGFloat(pixel)
//            case 1:
//                greenMean = CGFloat(pixel)
//            case 2:
//                redMean = CGFloat(pixel)
//            case 3:
//                break
//            default:
//                break
//            }
//            bgraIndex += 1
//        }
//        let hsv = rgb2hsv((red: redMean, green: greenMean, blue: blueMean, alpha: 1.0))
//        // Do a sanity check to see if a finger is placed over the camera
//        if hsv.1 > 0.5 && hsv.2 > 0.5 {
//            DispatchQueue.main.async {
//                self.thresholdText = "人差し指 ☝️ を\nカメラに当てたまま待ってください"
//                if !self.measurementStartedFlag {
//                    self.toggleTorch(status: true)
//                    self.startMeasurement()
//                    self.measurementStartedFlag = true
//                }
//            }
//            validFrameCounter += 1
//            inputs.append(hsv.0)
//            /* Filter the hue value
//                - the filter is a simple BAND PASS FILTER
//                  that removes any DC component and any high
//                  frequency noise
//             */
//            let filtered = hueFilter.processValue(value: Double(hsv.0))
//            if validFrameCounter > 60 {
//                self.pulseDetector.addNewValue(newVal: filtered, atTime: CACurrentMediaTime())
//            }
//        } else {
//            validFrameCounter = 0
//            measurementStartedFlag = false
//            pulseDetector.reset()
//            DispatchQueue.main.async {
//                self.toggleTorch(status: false)
//                self.thresholdText = "バックカメラに赤色 🟥　になるまで指をあててください"
//            }
//        }
//    }
//}
