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
            if viewStore.isLogedIn
                && UserDefaults.standard.string(forKey: UserDefaultsString.officeId) != nil {
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
                WorkerNewSignUpView(
                    store: store,
                    backToTopViewAction: {
                        viewStore.send(.goToNewSignInView(false))
                    }
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
        }
    }
}

struct WorkerTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerTopView(
            store: Store(
                initialState: WorkerTopState(),
                reducer: workerReducer,
                environment: WorkerTopEnvironment()
            )
        )
    }
}
