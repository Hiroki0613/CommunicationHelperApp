//
//  ContentView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/10.
//

/*
 【詳解】Firebase iOS SDKをSwift Package Manager (SwiftPM)で導入する
 https://qiita.com/ruwatana/items/80da4b1d5f4906bdd38c
 https://firebase.google.com/docs/ios/setup?hl=ja
 https://firebase.google.com/docs/ios/setup
 【Xcode】すでに追加済みのSwift Packageの別のパッケージプロダクトを追加する方法
 https://dev.classmethod.jp/articles/spm-add-new-package-product/
 
 
 signInWithApple
 SwiftUIでFirebaseAuthを使用してSign in with Apple 実装
 https://qiita.com/hideto1198/items/f0ee7acd757c6ea763b0
 
 
 */

/*
 Firebaseのコマンドは無理にTCAに合わせないで、とりあえず実装しておく。そして、TCAの理解が深まったらコードを整理する方向にする。
 オーナーはメールアドレス＋パスワード、appleログイン。
 　セキュリティーを考えると、appleアカウントを作ってもらうのがベストだとは思う。
 
 staff、workerはアニノマスログインを行う。
 */

import Combine
import CoreMotion
import SwiftUI

struct TopView: View {
    // TODO: オーナー側はemail、passwordのログイン or appleIDログインを使う。というより、apple側が強制してくる。
    // TODO: staff、worker側は正しいQRコードを読み取り次第、アニノマスログインを行う。
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(
                    destination: {
                        WorkerTopView()
                    },
                    label: {
                        Text("利用者さん")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 96)
                            .background(PrimaryColor.buttonColor)
                            .cornerRadius(20)
                            .padding(.horizontal, 22)
                    }
                )
                Spacer().frame(height: 66)
                NavigationLink(
                    destination: {
                        // TODO: 現時点では、オーナー側はダミーQRコードが出るようにする。
                        OwnerQRCodeView()
                    }, label: {
                        Text("支援者さん")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 96)
                            .background(PrimaryColor.buttonColor)
                            .cornerRadius(20)
                            .padding(.horizontal, 22)
                    }
                )
                Spacer().frame(height: 66)
                NavigationLink(
                    destination: {
                        // TODO: 現時点では、オーナー側はダミーQRコードが出るようにする。
                        TestView()
                    }, label: {
                        Text("テスト画面")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(PrimaryColor.buttonColor)
                            .cornerRadius(20)
                            .padding(.horizontal, 80)
                    }
                )
                Spacer()
            }
            .background(PrimaryColor.background)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}


struct TestView: View {
    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Text("デバッグ画面")
                    .fontWeight(.semibold)
                    .font(.system(size: 12))
                    .foregroundColor(Color.black)
                NavigationLink(
                    destination: {
                        // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                        WorkerNewSignUpView()
                    },
                    label: {
                        Text("新規登録時\n(QRリーダー起動)")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(PrimaryColor.buttonColor)
                            .padding(.horizontal, 22)
                    }
                )
                Spacer().frame(height: 20)
                NavigationLink(
                    destination: {
                        // TODO: プロモーションのために暫定でQRコードを表示させている。
                        WorkerQRCodeView()
                    },
                    label: {
                        Text("朝の出勤時\nQRコードが出ます")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(PrimaryColor.buttonColor)
                            .padding(.horizontal, 22)
                    }
                )
                Spacer().frame(height: 20)
                NavigationLink(
                    destination: {
                        // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                        WorkerPulseTopView()
                    },
                    label: {
                        Text("心拍測定時\nパルスリーダー")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(PrimaryColor.buttonColor)
                            .padding(.horizontal, 22)
                    }
                )
                Spacer().frame(height: 20)
                NavigationLink(
                    destination: {
                        // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                        WorkerEndOfWorkTopView()
                    },
                    label: {
                        Text("退勤時")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(PrimaryColor.buttonColor)
                            .padding(.horizontal, 22)
                    }
                )
                Spacer().frame(height: 20)
                NavigationLink(
                    destination: {
                        PressureView()
                    },
                    label: {
                        Text("気圧計")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(PrimaryColor.buttonColor)
                            .padding(.horizontal, 22)
                    }
                )
            }
        }
    }
}

class AltimatorManager: NSObject, ObservableObject {
    let willChange = PassthroughSubject<Void, Never>()
    var altimeter: CMAltimeter?
    @Published var pressureString:String = ""

    override init() {
        super.init()
        altimeter = CMAltimeter()
        startUpdate()
    }

    func doReset() {
        altimeter?.stopRelativeAltitudeUpdates()
        startUpdate()
    }

    func startUpdate() {
        if( CMAltimeter.isRelativeAltitudeAvailable() ) {
            altimeter!.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler:
                {data, error in
                    if error == nil {
                        let pressure:Double = data!.pressure.doubleValue
                        self.pressureString = String(format: "気圧:%.1f hPa",pressure * 10)
                        self.willChange.send()
                    }
            })
        }
    }

}

struct PressureView: View {
    @ObservedObject var manager = AltimatorManager()
    let availabe = CMAltimeter.isRelativeAltitudeAvailable()
    
    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack(spacing: 30) {
                VStack(spacing: 30) {
                    Text(availabe ? manager.pressureString : "----")
                }
                Button(action: {
                    self.manager.doReset()
                }) {
                    Text("リセット")
                }
            }
        }
    }
}
