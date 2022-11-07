//
//  QrCodeCameraDelegate.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//
import AVFoundation

class QrCodeCameraDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var scanInterval: Double = 1.0
    var lastTime = Date(timeIntervalSince1970: 0)
    var onResult: (String) -> Void = { _ in }
    var mockData: String?

    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
//        if let metadataObject = metadataObjects.first {
//            guard let redableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return}
//            guard let stringValue = redableObject.stringValue else { return }
//            foundBarcode(stringValue)
//        }
        for metadataObject in metadataObjects {
            guard let machineReadableCode = metadataObject as? AVMetadataMachineReadableCodeObject,
                  machineReadableCode.type == .qr,
                  let stringValue = machineReadableCode.stringValue else { return }
            foundBarcode(stringValue)
        }
    }

    @objc func onSimulateScanning() {
        foundBarcode(mockData ?? "Simulated QR-Code result")
    }

    private func foundBarcode(_ stringValue: String) {
        let now = Date()
        if now.timeIntervalSince(lastTime) >= scanInterval {
            lastTime = now
            self.onResult(stringValue)
        }
    }
}
