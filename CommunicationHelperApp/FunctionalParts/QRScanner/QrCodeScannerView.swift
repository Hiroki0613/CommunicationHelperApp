//
//  QrCodeScannerView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//

import AVFoundation
import SwiftUI
import UIKit

// https://qiita.com/ikaasamay/items/58d1a401e98673a96fd2
struct QrCodeScannerView: UIViewRepresentable {
    var supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]
    typealias UIViewType = CameraPreviewView

    private let session = AVCaptureSession()
    private let delegate = QrCodeCameraDelegate()
    private let metadataOutput = AVCaptureMetadataOutput()

    func interval(delay: Double) -> QrCodeScannerView {
        delegate.scanInterval = delay
        return self
    }

    func found(read: @escaping (String) -> Void) -> QrCodeScannerView {
        print("found")
        delegate.onResult = read
        return self
    }

    func setupCamera(_ uiView: CameraPreviewView) {
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

    func makeUIView(context: Context) -> CameraPreviewView {
        let cameraView = CameraPreviewView(session: session)
        checkCameraAuthorizationStatus(cameraView)
        return cameraView
    }

    static func dismantleUIView(_ uiView: CameraPreviewView, coordinator: ()) {
        uiView.session.stopRunning()
    }

    private func checkCameraAuthorizationStatus(_ uiView: CameraPreviewView) {
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

    func updateUIView(_ uiView: CameraPreviewView, context: Context) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}





struct QrCodeScannerViewSecond: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> QrCodeScannerVC {
        QrCodeScannerVC()
    }

    func updateUIViewController(_ uiViewController: QrCodeScannerVC, context: Context) {
    }
}

final class QrCodeScannerVC: UIViewController {
    var preview: UIView!
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = preview.bounds
        layer.videoGravity = .resizeAspectFill
        layer.connection?.videoOrientation = .portrait
        return layer
    }()
    private var boundingBox = CAShapeLayer()
    private var allowDuplicateReading: Bool = false
    private var makeHapticFeedback: Bool = false
    private var showBoundingBox: Bool = false
    private var scannedQRs = Set<String>()
    private let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private var videoDevice: AVCaptureDevice?
    private var videoDeviceInput: AVCaptureDeviceInput?
    private let metadataOutput = AVCaptureMetadataOutput()
    private let metadataObjectQueue = DispatchQueue(label: "metadataObjectQueue")

    override func viewDidLoad() {
        super.viewDidLoad()
//        preview.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(self.preview)
//
//
//        NSLayoutConstraint.activate([
//            preview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            preview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            preview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            preview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
        preview = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: UIScreen.main.bounds.size.width,
                                                   height: UIScreen.main.bounds.size.height))
                preview.contentMode = UIView.ContentMode.scaleAspectFit
                view.addSubview(preview)
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {
                    // 😭
                }
            }
        default:
            print("The user has previously denied access.")
        }
//        DispatchQueue.main.async {
//            self.setupBoundingBox()
//        }
        
        sessionQueue.async {
            self.configureSession()
        }
        preview.layer.addSublayer(previewLayer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.session.startRunning()
        sessionQueue.async {
            
            self.session.startRunning()
        }
    }

    // MARK: configureSession
    private func configureSession() {
        session.beginConfiguration()
        let defaultVideoDevice = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .back
        )
        guard let videoDevice = defaultVideoDevice else {
            session.commitConfiguration()
            return
        }
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            }
        } catch {
            session.commitConfiguration()
            return
        }
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: metadataObjectQueue)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            session.commitConfiguration()
        }
        session.commitConfiguration()
    }

//    private func setupBoundingBox() {
//        boundingBox.frame = preview.layer.bounds
//        boundingBox.strokeColor = UIColor.green.cgColor
//        boundingBox.lineWidth = 4.0
//        boundingBox.fillColor = UIColor.clear.cgColor
//        preview.layer.addSublayer(boundingBox)
//    }
//
//    // MARK: Haptic feedback
//    private func hapticSuccessNotification() {
//        if makeHapticFeedback == true {
//            let generator = UINotificationFeedbackGenerator()
//            generator.prepare()
//            generator.notificationOccurred(.success)
//        }
//    }
}

extension QrCodeScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadataObject in metadataObjects {
            guard let machineReadableCode = metadataObject as? AVMetadataMachineReadableCodeObject,
                  machineReadableCode.type == .qr,
                  let stringValue = machineReadableCode.stringValue
            else { return }
            print("hirohiro_new_stringValue: ", stringValue)
        }
    }
}
