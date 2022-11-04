//
//  WorkerNewSignUpView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/30.
//

import SwiftUI

struct WorkerNewSignUpView: View {
    @ObservedObject var viewModel = ScannerViewModel()

    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Text("新規登録")
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                // 読み取ったQRコード表示位置
                Button(
                    action: {
                        viewModel.isShowing = true
                }, label: {
                    VStack {
                        Text("カメラ起動")
                        Image(systemName: "camera")
                    }
                    .foregroundColor(Color.black)
                    .frame(width: 164, height: 155)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                })
                .fullScreenCover(isPresented: $viewModel.isShowing) {
                    QRCameraView(viewModel: viewModel)
                }
            }

        }
    }
}

struct QRCameraView: View {
    @ObservedObject var viewModel: ScannerViewModel

    var body: some View {
        ZStack {
            QrCodeScannerView()
                .found(read: self.viewModel.onFoundQrCode)
                .interval(delay: self.viewModel.scanInterval)
            VStack {
                VStack {
                    // TODO: QRコードの値をUserDefaultで保存
                    let _ = print("hirohiro_qrCode: ", viewModel.lastQrCode)
                    Spacer().frame(height: 40)
                    Text("QRコードを読み込んでください")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(PrimaryColor.buttonColor)
                        .cornerRadius(20)
                        .padding(.horizontal, 22)
                    Spacer()
                    Button(action: {
                        self.viewModel.isShowing = false
                    }, label: {
                        Text("閉じる")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 92)
                            .background(PrimaryColor.buttonColor)
                            .cornerRadius(20)
                            .padding(.horizontal, 22)
                    })
                    Spacer().frame(height: 30)
                }
                .padding(.vertical, 20)
                Spacer()
            }
            .padding()
        }
    }
}

struct WorkerNewSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerNewSignUpView()
    }
}
