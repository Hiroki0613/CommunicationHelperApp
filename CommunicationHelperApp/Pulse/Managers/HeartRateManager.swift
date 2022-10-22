//
//  HeartRateManager.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//

// https://github.com/athanasiospap/Pulse
import AVFoundation

enum CameraType: Int {
    case back
    case front

    func captureDevice() -> AVCaptureDevice {
        switch self {
        case .front:
            let devices = AVCaptureDevice.DiscoverySession(
                deviceTypes: [],
                mediaType: AVMediaType.video,
                position: .front
            ).devices
            print("devices:\(devices)")
            for device in devices where device.position == .front {
                return device
            }
        default:
            break
        }
        // TODO: 暫定で強制アンラップをしているので注意
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
    }
}

struct VideoSpec {
    var fps: Int32?
    var size: CGSize?
}
