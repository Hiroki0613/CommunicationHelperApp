//
//  CommunicationHelperApp.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/10.
//

import ComposableArchitecture
import Firebase
import SwiftUI

@main
struct CommunicationHelperApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            TopView(
                store: Store(
                    initialState: TopState(
                        ownerState: OwnerTopState(),
                        workerTopState: WorkerTopState()
                    ),
                    reducer: topReducer,
                    environment: TopEnvironment()
                )
            )
//            WorkerChatInputFiveWsAndOneHView(
//                store: Store(
//                    initialState: WorkerChatInputFiveWsAndOneHState(),
//                    reducer: workerChatInputFiveWsAndOneHReducer,
//                    environment: WorkerChatInputFiveWsAndOneHEnvironment()
//                )
//            )
//            AuthTestView()
        }
    }
}
