//
//  WorkerTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//
import AVFoundation
import SwiftUI

struct WorkerTopView: View {
    var body: some View {
        ZStack {
            PrimaryColor.background
            FirstView()
        }
    }
}

struct WorkerTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerTopView()
    }
}

struct FirstView: View {
    @ObservedObject var viewModel = ScannerViewModel()

    var body: some View {
        VStack {
            Text("QR Code Reader")
                .padding()
            // 読み取ったQRコード表示位置
            Text("URL = [ " + viewModel.lastQrCode + " ]")
            Button(action: {
                viewModel.isShowing = true
            }){
                Text("カメラ起動")
                Image(systemName: "camera")
            }
            .fullScreenCover(isPresented: $viewModel.isShowing) {
                SecondView(viewModel: viewModel)
            }
        }
    }
}

struct SecondView: View {
    @ObservedObject var viewModel: ScannerViewModel

    var body: some View {
        ZStack {
            QrCodeScannerView()
                .found(read: self.viewModel.onFoundQrCode)
                .interval(delay: self.viewModel.scanInterval)
            VStack {
                VStack {
                    Text("Keep scanning for QR-codes")
                        .font(.subheadline)
                    Text("QRコード読み取り結果 = [ " + self.viewModel.lastQrCode + " ]")
                        .bold()
                        .lineLimit(5)
                        .padding()
                    Button("Close") {
                        self.viewModel.isShowing = false
                    }
                }
                .padding(.vertical, 20)
                Spacer()
            }
            .padding()
        }
    }
}
