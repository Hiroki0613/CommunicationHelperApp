//
//  CommunicationHelperApp.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/10.
//

import ComposableArchitecture
import SwiftUI

@main
struct CommunicationHelperApp: App {

    var body: some Scene {
        WindowGroup {
//            TopView(
//                store: Store(
//                    initialState: TopState(
//                        ownerState: OwnerState(),
//                        workerState: WorkerState()
//                    ),
//                    reducer: topReducer,
//                    environment: TopEnvironment()
//                )
//            )
            TopView()
        }
    }
}
