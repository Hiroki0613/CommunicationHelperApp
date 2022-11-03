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
    let store: Store<WorkerState, WorkerAction>
    // TODO: 設定した時間によるFirebaseでの変更
    var mode: Mode = .endOfTheWork

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationLink(
                isActive: viewStore.binding(
                    get: \.isActivePulseView,
                    send: WorkerAction.setNavigationToPulseView
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
                    send: WorkerAction.setNavigationToEndOfWorkView
                ),
                destination: {
                    WorkerEndOfWorkQRCodeView()
                },
                label: {
                 EmptyView()
                }
            )
            if viewStore.isLogedIn {
                switch mode {
                case .startOfWork:
                    // TODO: QRコードは端末固有のID。
                    WorkerQRCodeView()
                case .working:
                    WorkerPulseTopView(
                        action: {
                            viewStore.send(.setNavigationToPulseView(true))
                        }
                    )
                case .endOfTheWork:
                    WorkerEndOfWorkTopView(
                        action: {
                            viewStore.send(.setNavigationToEndOfWorkView(true))
                        }
                    )
                }
            } else {
                // TODO: QRコードを読み取り、UserDefaultsで保存。
                WorkerNewSignUpView()
            }
        }
    }
}

struct WorkerTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerTopView(
            store: Store(
                initialState: WorkerState(),
                reducer: workerReducer,
                environment: WorkerEnvironment()
            )
        )
    }
}
