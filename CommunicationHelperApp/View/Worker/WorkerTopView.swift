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
    var mode: Mode = .endOfTheWork

    var body: some View {
        if isLogedIn {
            switch mode {
            case .startOfWork:
                // TODO: プロモーションのために暫定でQRコードを表示させている。
                WorkerQRCodeView()
            case .working:
                // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                WorkerPulseTopView()
            case .endOfTheWork:
                // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                WorkerEndOfWorkTopView()
            }
        } else {
            // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                WorkerNewSignUpView()
        }
    }
}

struct WorkerTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerTopView()
    }
}
