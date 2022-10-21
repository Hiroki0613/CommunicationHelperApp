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

/*
 QRコードをswiftUIで作る方法
 【SwiftUI】QRコードを生成して、中心に可愛いアイコンを付ける方法
 https://dev.classmethod.jp/articles/swift-generate-qr-code/
 */

import SwiftUI

struct TopView: View {
    var body: some View {
        ZStack {
            Color(red: 0.424, green: 0.780, blue: 0.761)
            VStack {
                // TODO: 一番最初の画面でオーナー、スタッフ、作業者を分ける。 初期設定はオーナーが設定するので、少し難し目の作業でもOK
                
                // TODO: 2つの画面を用意
                
                    Spacer()
                    Button(
                        action: {
                        print("オーナー画面に遷移")
                    }, label: {
                        Text("利用者さん")
                            .fontWeight(.semibold)
                             .font(.system(size: 20))
                             // フォントの色
                            // ボタンの色
                             .foregroundColor(Color.black)
                             .frame(maxWidth: .infinity, minHeight: 96)
                             .background(Color(red: 0.961, green: 0.961, blue: 0.937))

                             // 両端にpaddingをかける
                             .padding(.horizontal, 22)
                    })
                    Spacer().frame(height: 100)
                    Button(
                        action: {
                        print("Staff、Worker画面に遷移")
                    }, label: {
                        Text("支援者さん")
                            .fontWeight(.semibold)
                             .font(.system(size: 20))
                             // フォントの色
                            // ボタンの色
                             .foregroundColor(Color.black)
                             .frame(maxWidth: .infinity, minHeight: 96)
                             .background(Color(red: 0.961, green: 0.961, blue: 0.937))

                             // 両端にpaddingをかける
                             .padding(.horizontal, 22)
                        
                    })
                    Spacer()
                
                // TODO: オーナー側はemail、passwordのログイン or appleIDログインを使う。というより、apple側が強制してくる。
                // TODO: 現時点では、オーナー側はダミーQRコードが出るようにする。
                // TODO: staff、worker側はカメラが起動して、QRコードリーダーを使えるようにする。
                // TODO: staff、worker側は正しいQRコードを読み取り次第、アニノマスログインを行う。
                // TODO: まず、worker側の作成、パルスリーダを実装する
                // TODO: 設定した時間ごとに画面が変わるようにする。 とりあえず、時間はXcodeで手打ちで設定する。
                // TODO: ここの段階では心拍数の結果がわかるだけで良い。保存は次のステップにする。
                
            }
        }

    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
