//
//  TopCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/18.
//

import ComposableArchitecture

struct TopState: Equatable {
    var ownerState: OwnerState
    var workerState: WorkerTopState
    var isShowingNewSignIn = false
}

enum TopAction {
    case ownerAction(OwnerAction)
    case workerAction(WorkerTopAction)
    case goToNewSignInView(Bool)
}

// TCAの観点から、理想はFirebaseの処理はenvironmentから行う。しかし、今回はaction+別modelでfuncを用意する方向にする。
struct TopEnvironment {
    var ownerEnvironment: OwnerEnvironment {
        .init()
    }
    var workerEnvironment: WorkerTopEnvironment {
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
    Reducer<TopState, TopAction, TopEnvironment> { state, action, _ in
        switch action {
        case .ownerAction:
            return .none

        case .workerAction(.goToNewSignInView(let isActive)):
            return Effect(value: .goToNewSignInView(isActive))

        case .workerAction:
            return .none

        case .goToNewSignInView(let isActive):
            state.isShowingNewSignIn = isActive
            return .none
        }
    }
)
