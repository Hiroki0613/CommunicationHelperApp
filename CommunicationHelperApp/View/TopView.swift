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
 SwiftUI + FirebaseUIのセットアップをしたときのメモ
 https://zenn.dev/kaorumori/articles/dc5373ba72f49e
 FirebaseUIをSwiftUIで表示する
 https://qiita.com/From_F/items/5888c548a9a41232509f
 SwiftUIからFirebaseUIを使う
 https://zenn.dev/yorifuji/articles/swiftui-firebaseui
 
 */

/*
 Firebaseのコマンドは無理にTCAに合わせないで、とりあえず実装しておく。そして、TCAの理解が深まったらコードを整理する方向にする。
 オーナーはメールアドレス＋パスワード、appleログイン。
 　セキュリティーを考えると、appleアカウントを作ってもらうのがベストだとは思う。
 
 staff、workerはアニノマスログインを行う。
 */

import ComposableArchitecture
import SwiftUI

struct TopView: View {
    @State var flag = false
    let store: Store<TopState, TopAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ZStack {
                    VStack {
                        Spacer()
                        NavigationLink(
                            isActive: viewStore.binding(
                                get: \.isShowingNewSignIn,
                                send: TopAction.goToNewSignInView
                            ),
                            destination: {
                                WorkerTopView(
                                    store: store.scope(
                                        state: \.workerTopState,
                                        action: TopAction.workerTopAction
                                    )
                                )
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
                        Spacer()
                    }
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            NavigationLink(
//                                destination: {
//                                    TestWorkerView(
//                                        store: Store(
//                                            initialState: WorkerTopState(),
//                                            reducer: workerTopReducer,
//                                            environment: WorkerTopEnvironment()
//                                        )
//                                    )
//                                }, label: {
//                                    Text("worker\ntest")
//                                        .fontWeight(.semibold)
//                                        .font(.system(size: 12))
//                                        .foregroundColor(Color.black)
//                                        .frame(maxWidth: 70, minHeight: 70)
//                                        .background(PrimaryColor.buttonColor)
//                                        .cornerRadius(35)
//                                }
//                            )
//                            Spacer().frame(width: 40)
//                        }
//                        Spacer().frame(height: 20)
//                    }
                }
                .background(PrimaryColor.backgroundGlay)
//                .background(switchBackGrondColors())
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
        }
    }
    func switchColors() -> Color {
        if UserDefaultsDataStoreProvider.provide().isBlackAndWhiteMode ?? false {
            return PrimaryColor.buttonLightGray
        } else {
            return PrimaryColor.buttonWhite
        }
    }
    func switchBackGrondColors() -> Color {
        if UserDefaultsDataStoreProvider.provide().isBlackAndWhiteMode ?? false {
            return PrimaryColor.backgroundBlack
        } else {
            return PrimaryColor.backgroundGreen
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(
            store: Store(
                initialState: TopState(
                    ownerState: OwnerTopState(),
                    workerTopState: WorkerTopState()
                ), reducer: topReducer,
                environment: TopEnvironment()
            )
        )
    }
}
