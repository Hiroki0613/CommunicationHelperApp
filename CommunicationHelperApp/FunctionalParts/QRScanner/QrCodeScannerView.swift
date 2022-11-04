//
//  QrCodeScannerView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//

import AVFoundation
import SwiftUI

// https://qiita.com/ikaasamay/items/58d1a401e98673a96fd2
struct QrCodeScannerView: UIViewRepresentable {
    var supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]
    typealias UIViewType = CameraPreiew

    private let session = AVCaptureSession()
    private let delegate = QrCodeCameraDelegate()
    private let metadataOutput = AVCaptureMetadataOutput()

    func interval(delay: Double) -> QrCodeScannerView {
        delegate.scanInterval = delay
        return self
    }

    func found(read: @escaping (String) -> Void) -> QrCodeScannerView {
        print("found")
        // TODO: QRコードを読み取り、UserDefaultsで保存。
        delegate.onResult = read
        return self
    }

    func setupCamera(_ uiView: CameraPreiew) {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if let input = try? AVCaptureDeviceInput(device: backCamera) {
                session.sessionPreset = .photo
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)
                    metadataOutput.metadataObjectTypes = supportedBarcodeTypes
                    metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                }
                let previewLayer = AVCaptureVideoPreviewLayer(session: session)
                uiView.backgroundColor = UIColor.gray
                previewLayer.videoGravity = .resizeAspectFill
                uiView.layer.addSublayer(previewLayer)
                uiView.previewLayer = previewLayer
                session.startRunning()
            }
        }
    }

    func makeUIView(context: Context) -> CameraPreiew {
        let cameraView = CameraPreiew(session: session)
        checkCameraAuthorizationStatus(cameraView)
        return cameraView
    }

    static func dismantleUIView(_ uiView: CameraPreiew, coordinator: ()) {
        uiView.session.stopRunning()
    }

    private func checkCameraAuthorizationStatus(_ uiView: CameraPreiew) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if cameraAuthorizationStatus == .authorized {
            setupCamera(uiView)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { _ in
                DispatchQueue.main.sync {
                    self.setupCamera(uiView)
                }
            }
        }
    }

    func updateUIView(_ uiView: CameraPreiew, context: Context) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
