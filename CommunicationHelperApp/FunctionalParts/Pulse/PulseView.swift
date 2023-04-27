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
        return PulseViewController(messageText: messageText)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
