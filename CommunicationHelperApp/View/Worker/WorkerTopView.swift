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

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationLink(
                isActive: viewStore.binding(
                    get: \.isActivePulseView,
                    send: WorkerAction.goToPulseView
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
                    send: WorkerAction.goToEndOfWorkView
                ),
                destination: {
                    WorkerEndOfWorkQRCodeView()
                },
                label: {
                 EmptyView()
                }
            )
            if viewStore.isLogedIn {
                switch viewStore.mode {
                case .startOfWork:
                    WorkerQRCodeView()
                case .working:
                    WorkerPulseTopView(
                        action: {
                            viewStore.send(.goToPulseView(true))
                        }
                    )
                case .endOfTheWork:
                    WorkerEndOfWorkTopView(
                        action: {
                            viewStore.send(.goToEndOfWorkView(true))
                        }
                    )
                }
            } else {
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
