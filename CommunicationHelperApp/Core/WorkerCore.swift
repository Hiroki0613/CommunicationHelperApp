//
//  WorkerCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/29.
//

import ComposableArchitecture

struct WorkerState: Equatable {
    var isActivePulseView = false
    var isActiveEndOfWorkView = false
}

enum WorkerAction {
    case setNavigationToPulseView(Bool)
    case setNavigationToEndOfWorkView(Bool)
}

struct WorkerEnvironment {

}

let workerReducer = Reducer<WorkerState, WorkerAction, WorkerEnvironment> { state, action, _ in
    switch action {
    case .setNavigationToPulseView(let isActive):
        state.isActivePulseView = isActive
        return .none

    case .setNavigationToEndOfWorkView(let isActive):
        state.isActiveEndOfWorkView = isActive
        return .none
    }
}
