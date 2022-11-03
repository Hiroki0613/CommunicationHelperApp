//
//  WorkerCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/29.
//

import ComposableArchitecture

struct WorkerState: Equatable {
    var isLogedIn = false
    var mode: Mode = .startOfWork
    var isActivePulseView = false
    var isActiveEndOfWorkView = false
    var terminalId = ""
}

enum WorkerAction {
    case setNavigationToPulseView(Bool)
    case setNavigationToEndOfWorkView(Bool)
    case onAppear
    case checkLogedIn
    case setModeForWorker
    case getTerminalIdFromUserDefaults
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

    case .onAppear:
        return .concatenate(
            Effect(value: .checkLogedIn),
            Effect(value: .setModeForWorker),
            Effect(value: .getTerminalIdFromUserDefaults)
        )

    case .checkLogedIn:
        return .none

    case .setModeForWorker:
        return .none

    case .getTerminalIdFromUserDefaults:
        return .none
    }
}
