//
//  WorkerTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//
import ComposableArchitecture
import AVFoundation
import SwiftUI

enum Mode {
    case startOfWork
    case working
    case endOfTheWork
}

struct WorkerTopView: View {
    let store: Store<WorkerTopState, WorkerTopAction>
    var userDefault: UserDefaultDataStore = UserDefaultsDataStoreProvider.provide()

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationLink(
                isActive: viewStore.binding(
                    get: \.isActivePulseView,
                    send: WorkerTopAction.goToPulseView
                ),
                destination: {
                    PulseView()
                },
                label: {
                 EmptyView()
                }
            )
            NavigationLink(
                isActive: viewStore.binding(
                    get: \.isActiveEndOfWorkView,
                    send: WorkerTopAction.goToEndOfWorkView
                ),
                destination: {
                    WorkerEndOfWorkQRCodeView()
                },
                label: {
                 EmptyView()
                }
            )
            ZStack {
                if viewStore.isLogedIn && userDefault.officeId != nil {
                    switch viewStore.mode {
                    case .startOfWork:
                        WorkerQRCodeView()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                    case .working:
                        WorkerPulseTopView(
                            action: {
                                viewStore.send(.goToPulseView(true))
                            }
                        )
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                    case .endOfTheWork:
                        WorkerEndOfWorkTopView(
                            action: {
                                viewStore.send(.goToEndOfWorkView(true))
                            }
                        )
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                    }
                } else {
                    // TODO: トップ画面ではなく、WorkerTopViewでアニノマスログインをする。
                    // TODO: ここはif文での分岐ではなく、フルスクリーンカバーにする。そのほうが処理を記載しやすい。
                    WorkerNewSignUpView(
                        store: store,
                        backToTopViewAction: {
                            viewStore.send(.goToNewSignInView(false))
                        }
                    )
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Button(
                                action: {
                                    viewStore.send(.testChangeView(.startOfWork))
                                }, label: {
                                    Text("始業")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: 70, minHeight: 70)
                                        .background(PrimaryColor.buttonColor)
                                        .cornerRadius(35)
                                }
                            )
                            Spacer().frame(height: 20)
                            Button(
                                action: {
                                    viewStore.send(.testChangeView(.working))
                                }, label: {
                                    Text("作業中")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: 70, minHeight: 70)
                                        .background(PrimaryColor.buttonColor)
                                        .cornerRadius(35)
                                }
                            )
                            Spacer().frame(height: 20)
                            Button(
                                action: {
                                    viewStore.send(.testChangeView(.endOfTheWork))
                                }, label: {
                                    Text("終業")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: 70, minHeight: 70)
                                        .background(PrimaryColor.buttonColor)
                                        .cornerRadius(35)
                                }
                            )
                            Spacer().frame(height: 20)
                        }
                    }
                    Spacer().frame(height: 20)
                }
            }
        }
    }
}

struct WorkerTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerTopView(
            store: Store(
                initialState: WorkerTopState(),
                reducer: workerTopReducer,
                environment: WorkerTopEnvironment()
            )
        )
    }
}
