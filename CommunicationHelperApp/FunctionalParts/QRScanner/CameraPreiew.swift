//
//  CameraPreiew.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//

import AVFoundation
import UIKit

class CameraPreiew: UIView {
    private var label: UILabel?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var session = AVCaptureSession()
    weak var delegate: QrCodeCameraDelegate?

    init(session: AVCaptureSession) {
        super.init(frame: .zero)
        self.session = session
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func onClick() {
        delegate?.onSimulateScanning()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
    }
}