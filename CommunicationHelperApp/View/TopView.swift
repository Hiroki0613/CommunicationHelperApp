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

import ComposableArchitecture
import SwiftUI

struct TopView: View {
    let store: Store<TopState, TopAction>

    // TODO: オーナー側はemail、passwordのログイン or appleIDログインを使う。というより、apple側が強制してくる。
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
                                        state: \.workerState,
                                        action: TopAction.workerAction
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
                        Spacer().frame(height: 66)
                        NavigationLink(
                            destination: {
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
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(
                                destination: {
                                    TestOwnerView(
                                        store: Store(
                                            initialState: OwnerState(),
                                            reducer: ownerReducer,
                                            environment: OwnerEnvironment()
                                        )
                                    )
                                }, label: {
                                    Text("owner\ntest")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: 70, minHeight: 70)
                                        .background(PrimaryColor.buttonColor)
                                        .cornerRadius(35)
                                }
                            )
                            Spacer().frame(width: 40)
                        }
                        HStack {
                            Spacer()
                            NavigationLink(
                                destination: {
                                    TestWorkerView(
                                        store: Store(
                                            initialState: WorkerTopState(),
                                            reducer: workerReducer,
                                            environment: WorkerTopEnvironment()
                                        )
                                    )
                                }, label: {
                                    Text("worker\ntest")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: 70, minHeight: 70)
                                        .background(PrimaryColor.buttonColor)
                                        .cornerRadius(35)
                                }
                            )
                            Spacer().frame(width: 40)
                        }
                        Spacer().frame(height: 20)
                    }
                }
                .background(PrimaryColor.background)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(
            store: Store(
                initialState: TopState(
                    ownerState: OwnerState(),
                    workerState: WorkerTopState()
                ), reducer: topReducer,
                environment: TopEnvironment()
            )
        )
    }
}
