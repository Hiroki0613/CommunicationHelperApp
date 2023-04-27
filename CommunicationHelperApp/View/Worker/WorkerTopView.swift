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
                // TODO: 現状はリアルタイムでの更新が出来ていない状況。または、Firebaseが更新されたときに処理が走るようにする。userDefault.workerId != nil || workerSettingManager.workerId
                /*
                 
                 1. workerIdをcoreでstateを使って持たせる。
                 2. 初期値をオプショナルで持たせておいて、都度都度アンラップをしておく。
                 この方法だとデータが更新しない。
                 
                 observerで外部からの更新を受け取るほうが現実的だと思う。
                 observerはリアルタイム
                 */
                if userDefault.deviceId != nil && userDefault.ownerId != nil {
//                    if let _ = userDefault.workerId,
//                       let loginDate = userDefault.loginDate,
//                       Calendar.current.isDateInToday(loginDate) {
//                        WorkerChatTopView(
//                            store: store.scope(
//                                state: \.workerChatTopState,
//                                action: WorkerTopAction.workerChatTopAction
//                            )
//                        )
//                        .navigationBarTitleDisplayMode(.inline)
//                        .navigationBarHidden(true)
//                    } else {
//                        WorkerQRCodeView()
//                            .navigationBarTitleDisplayMode(.inline)
//                            .navigationBarHidden(true)
//                    }
                    if hasAlreadyMorningMeeting() {
                        WorkerChatTopView(
//                            store: store.scope(
//                                state: \.workerChatTopState,
//                                action: WorkerTopAction.workerChatTopAction
//                            )
                        )
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                    } else {
                        WorkerQRCodeView()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                    }
//                    switch viewStore.mode {
//                    case .startOfWork:
//                        WorkerQRCodeView()
//                            .navigationBarTitleDisplayMode(.inline)
//                            .navigationBarHidden(true)
//                    case .working:
//                        WorkerChatTopView(
//                            store: store.scope(
//                                state: \.workerChatTopState,
//                                action: WorkerTopAction.workerChatTopAction
//                            )
//                        )
//                        .navigationBarTitleDisplayMode(.inline)
//                        .navigationBarHidden(true)
//                    case .endOfTheWork:
//                        WorkerEndOfWorkTopView(
//                            action: {
//                                viewStore.send(.goToEndOfWorkView(true))
//                            }
//                        )
//                        .navigationBarTitleDisplayMode(.inline)
//                        .navigationBarHidden(true)
//                    }
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
                                        viewStore.send(.changeView(.startOfWork))
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
                                        viewStore.send(.changeView(.working))
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
                                        viewStore.send(.changeView(.endOfTheWork))
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

    private func hasAlreadyMorningMeeting() -> Bool {
        guard let index = workerSettingManager.workers.firstIndex(where: { $0.deviceId == userDefault.deviceId }) else { return false }
        let worker = workerSettingManager.workers[index]
        print("hirohiro_hasAlreadyMorningMeeting: ", worker.workerId, worker.timestamp)
        if userDefault.workerId != nil || !worker.workerId.isEmpty,
           let userDefaultLoginDate = userDefault.loginDate,
           Calendar.current.isDateInToday(userDefaultLoginDate) || Calendar.current.isDateInToday(worker.timestamp) {
            return true
        }
        return false
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
