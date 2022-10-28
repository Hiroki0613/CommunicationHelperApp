//
//  PulseView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/23.
//

// https://github.com/athanasiospap/Pulse
import SwiftUI

struct PulseView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return PulseViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}
