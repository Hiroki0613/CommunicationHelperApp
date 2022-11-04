//
//  TopCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/18.
//

import ComposableArchitecture

struct TopState: Equatable {
    var workerState: WorkerState
}

enum TopAction {
    case workerAction(WorkerAction)
    // TODO: 理想はFirebaseの処理はenvironmentから行うのが良いが、今回はaction+別modelでfuncを用意する方向にする。
}

struct TopEnvironment {
    var workerEnvironment: WorkerEnvironment {
        .init()
    }
}

let topReducer = Reducer<TopState, TopAction, TopEnvironment>.combine(
    workerReducer.pullback(
        state: \.workerState,
        action: /TopAction.workerAction,
        environment: \.workerEnvironment
    ),
    Reducer<TopState, TopAction, TopEnvironment> { _, action, _ in
        switch action {
        case .workerAction:
            return .none
        }
    }
)
