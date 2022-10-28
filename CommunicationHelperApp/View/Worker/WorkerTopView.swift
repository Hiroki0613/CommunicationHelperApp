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
            VStack {
                Text("デバッグ画面")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                NavigationLink(
                    destination: {
                        // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                        WorkerNewSignUpView()
                    },
                    label: {
                        Text("新規登録時\n(QRリーダー起動)")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 96)
                            .background(PrimaryColor.buttonColor)
                            .padding(.horizontal, 22)
                    }
                )
                Spacer().frame(height: 30)
                NavigationLink(
                    destination: {
                        // TODO: プロモーションのために暫定でQRコードを表示させている。
                        WorkerQRCodeView()
                    },
                    label: {
                        Text("朝の出勤時\nQRコードリーダーが出ます")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 96)
                            .background(PrimaryColor.buttonColor)
                            .padding(.horizontal, 22)
                    }
                )
                Spacer().frame(height: 30)
                NavigationLink(
                    destination: {
                        // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                        WorkerPulseTopView()
                    },
                    label: {
                        Text("心拍測定時\nパルスリーダー")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 96)
                            .background(PrimaryColor.buttonColor)
                            .padding(.horizontal, 22)
                    }
                )
                Spacer().frame(height: 30)
                NavigationLink(
                    destination: {
                        // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                        WorkerEndOfWorkTopView()
                    },
                    label: {
                        Text("退勤時")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 96)
                            .background(PrimaryColor.buttonColor)
                            .padding(.horizontal, 22)
                    }
                )
            }
        }
    }
}

struct WorkerTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerTopView()
    }
}

struct WorkerNewSignUpView: View {
    @ObservedObject var viewModel = ScannerViewModel()

    var body: some View {
        ZStack {
            PrimaryColor.background
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


// QRコードを作成
struct WorkerQRCodeView: View {
    @State private var qrCodeImage: UIImage?
    private let qRCodeGenerator = QRCodeGenerator()

    var body: some View {
        ZStack {
            PrimaryColor.background
            if let qrCodeImage = qRCodeGenerator.generate(
                with: "https://dev.classmethod.jp/articles/swift-generate-qr-code/"
            ) {
                VStack {
                    Text("おはようございます。\nニックネームさん")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    Image(uiImage: qrCodeImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct WorkerPulseTopView: View {
    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Text("ニックネーム")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 92)
                    .background(PrimaryColor.buttonColor)
                    .padding(.horizontal, 19)
                Spacer().frame(height: 33)
                ZStack {
                    Rectangle()
                        .fill(PrimaryColor.buttonColor)
                        .frame(width: 282, height: 232)
                    VStack {
                        Spacer().frame(height: 13)
                        Text("心拍")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                        Spacer().frame(height: 80)
                        Text("70")
                            .fontWeight(.semibold)
                            .font(.system(size: 40))
                            .foregroundColor(Color.black)
                    }
                }
                Spacer().frame(height: 46)
                NavigationLink(
                    destination: {
                        PulseView()
                    },
                    label: {
                        Text("測定")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 96)
                            .background(PrimaryColor.buttonRedColor)
                            .padding(.horizontal, 84)
                    }
                )
            }
        }
    }
}

struct WorkerEndOfWorkTopView: View {
    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Text("ニックネーム")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 92)
                    .background(PrimaryColor.buttonColor)
                    .padding(.horizontal, 19)
                Spacer().frame(height: 33)
                ZStack {
                    Rectangle()
                        .fill(PrimaryColor.buttonColor)
                        .frame(width: 282, height: 232)
                    VStack {
                        Spacer().frame(height: 13)
                        Text("心拍")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                        Spacer().frame(height: 80)
                        Text("70")
                            .fontWeight(.semibold)
                            .font(.system(size: 40))
                            .foregroundColor(Color.black)
                    }
                }
                Spacer().frame(height: 46)
                NavigationLink(
                    destination: {
                        WorkerEndOfWorkQRCodeView()
                    },
                    label: {
                        Text("報告")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 96)
                            .background(PrimaryColor.buttonRedColor)
                            .padding(.horizontal, 84)
                    }
                )
            }
        }
    }
}

struct WorkerEndOfWorkView: View {
    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Text("ニックネーム")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 92)
                    .background(PrimaryColor.buttonColor)
                    .padding(.horizontal, 19)
                Spacer().frame(height: 33)
                ZStack {
                    Rectangle()
                        .fill(PrimaryColor.buttonColor)
                        .frame(width: 282, height: 232)
                    VStack {
                        Spacer().frame(height: 13)
                        Text("心拍")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                        Spacer().frame(height: 80)
                        Text("70")
                            .fontWeight(.semibold)
                            .font(.system(size: 40))
                            .foregroundColor(Color.black)
                    }
                }
                Spacer().frame(height: 24)
                ZStack {
                    Rectangle()
                        .fill(PrimaryColor.buttonColor)
                        .frame(width: 282, height: 143)
                    VStack {
                        Spacer().frame(height: 9)
                        Text("今日の振り返り")
                            .fontWeight(.semibold)
                            .font(.system(size: 24))
                            .foregroundColor(Color.black)
                        Spacer().frame(height: 100)
                    }
                }
            }
        }
    }
}

struct WorkerEndOfWorkQRCodeView: View {
    @State private var qrCodeImage: UIImage?
    private let qRCodeGenerator = QRCodeGenerator()

    var body: some View {
        ZStack {
            PrimaryColor.background
            if let qrCodeImage = qRCodeGenerator.generate(
                with: "https://dev.classmethod.jp/articles/swift-generate-qr-code/"
            ) {
                VStack {
                    Text("お疲れ様でした。\nニックネームさん")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    Image(uiImage: qrCodeImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Spacer().frame(height: 33)
                    NavigationLink(destination: {
                        WorkerEndOfWorkView()
                    }, label: {
                        Text("QRコードが読み込まれた後の画面")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                    })
                }
            }
        }
    }
}
