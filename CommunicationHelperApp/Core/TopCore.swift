//
//  TopCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/18.
//

import ComposableArchitecture

struct TopState: Equatable {
    var isBlackAndWhiteMode = false
    var ownerState: OwnerTopState
    var workerTopState: WorkerTopState
    var isShowingNewSignIn = false
}

enum TopAction {
    case ownerAction(OwnerTopAction)
    case workerTopAction(WorkerTopAction)
    case goToNewSignInView(Bool)
    case setColorModeByButton(Bool)
}

// TCAの観点から、理想はFirebaseの処理はenvironmentから行う。しかし、今回はaction+別modelでfuncを用意する方向にする。
struct TopEnvironment {
    var ownerEnvironment: OwnerTopEnvironment {
        .init()
    }
    var workerTopEnvironment: WorkerTopEnvironment {
        .init()
    }
}

let topReducer = Reducer<TopState, TopAction, TopEnvironment>.combine(
    ownerTopReducer.pullback(
        state: \.ownerState,
        action: /TopAction.ownerAction,
        environment: \.ownerEnvironment
    ),
    workerTopReducer.pullback(
        state: \.workerTopState,
        action: /TopAction.workerTopAction,
        environment: \.workerTopEnvironment
    ),
    Reducer<TopState, TopAction, TopEnvironment> { state, action, _ in
        switch action {
        case .ownerAction:
            return .none

        case .workerTopAction(.goToNewSignInView(let isActive)):
            return Effect(value: .goToNewSignInView(isActive))

        case .workerTopAction:
            return .none

        case .goToNewSignInView(let isActive):
            state.isShowingNewSignIn = isActive
            return .none

        case .setColorModeByButton(let flag):
            var userDefault: UserDefaultDataStore = UserDefaultsDataStoreProvider.provide()
            userDefault.isBlackAndWhiteMode = flag
            print("hirohiro_userDefault: ", userDefault.isBlackAndWhiteMode)
            return .none
        }
    }
)
