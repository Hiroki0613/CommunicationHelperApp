//
//  TestView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import SwiftUI

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

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
