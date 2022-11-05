//
//  TopCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/18.
//

import ComposableArchitecture

struct TopState: Equatable {
    var ownerState: OwnerState
    var workerState: WorkerState
}

enum TopAction {
    case ownerAction(OwnerAction)
    case workerAction(WorkerAction)
}

// TCAの観点から、理想はFirebaseの処理はenvironmentから行う。しかし、今回はaction+別modelでfuncを用意する方向にする。
struct TopEnvironment {
    var ownerEnvironment: OwnerEnvironment {
        .init()
    }
    var workerEnvironment: WorkerEnvironment {
        .init()
    }
}

let topReducer = Reducer<TopState, TopAction, TopEnvironment>.combine(
    ownerReducer.pullback(
        state: \.ownerState,
        action: /TopAction.ownerAction,
        environment: \.ownerEnvironment
    ),
    workerReducer.pullback(
        state: \.workerState,
        action: /TopAction.workerAction,
        environment: \.workerEnvironment
    ),
    Reducer<TopState, TopAction, TopEnvironment> { _, action, _ in
        switch action {
        case .ownerAction:
            return .none

        case .workerAction:
            return .none
        }
    }
)
