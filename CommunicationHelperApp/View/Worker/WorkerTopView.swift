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
    @StateObject var workerSettingManager = WorkerSettingManager()

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                let _ = print("hirohiro_UserDefaults: ", userDefault.deviceId, userDefault.ownerId, userDefault.workerId)
                if userDefault.deviceId != nil && userDefault.ownerId != nil {
                    
                    // TODO: if文のネストだけど、一旦の制御をかけよう。
                    
                    switch viewStore.mode {
                    case .startOfWork:
                        WorkerQRCodeView()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                    case .working:
                        WorkerChatTopView(
                            store: store.scope(
                                state: \.workerChatTopState,
                                action: WorkerTopAction.workerChatTopAction
                            )
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
                            if userDefault.deviceId != nil && userDefault.ownerId != nil {
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
                    }
                    Spacer().frame(height: 20)
                }
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.isActivePulseView,
                    send: WorkerTopAction.goToPulseView
                )
            ) {
                PulseView(messageText: "hirohiro_WorkerTopViewから来た")
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.isActiveEndOfWorkView,
                    send: WorkerTopAction.goToEndOfWorkView
                )
            ) {
                WorkerEndOfWorkQRCodeView()
            }
            .onAppear {
                workerSettingManager.getWorkerData()
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
