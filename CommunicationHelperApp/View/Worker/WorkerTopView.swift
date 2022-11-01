//
//  WorkerTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//
import AVFoundation
import SwiftUI

enum Mode {
    case startOfWork
    case working
    case endOfTheWork
}

struct WorkerTopView: View {
    var isLogedIn = true
    var mode: Mode = .working

    // TODO: 設定した時間ごとに画面が変わるようにする。 とりあえず、時間はXcodeで手打ちで設定する。
    var body: some View {
        if isLogedIn {
            switch mode {
            case .startOfWork:
                // TODO: QRコードは端末固有のID。
                WorkerQRCodeView()
            case .working:
                // TODO: EmptyViewを使って、隠れナビゲーションViewを作る。
                WorkerPulseTopView()
            case .endOfTheWork:
                // TODO: EmptyViewを使って、隠れナビゲーションViewを作る。
                WorkerEndOfWorkTopView()
            }
        } else {
            // TODO: QRコードを読み取り、UserDefaultsで保存。
            WorkerNewSignUpView()
        }
    }
}

struct WorkerTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerTopView()
    }
}
