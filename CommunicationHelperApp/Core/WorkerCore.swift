//
//  WorkerCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/29.
//

import ComposableArchitecture
import Foundation

struct WorkerState: Equatable {
    var isLogedIn = false
    var mode: Mode = .startOfWork
    var isActivePulseView = false
    var isActiveEndOfWorkView = false
    // デフォルトで8時30分
    var startTime: Date?
    // デフォルトで17時30分
    var endTime: Date?
    var terminalId = ""
}

enum WorkerAction {
    case goToPulseView(Bool)
    case goToEndOfWorkView(Bool)
    case onAppear
    case checkAccount
    case login
    case logout
    case setWorkerData
    case getTerminalIdFromUserDefaults
}

struct WorkerEnvironment {
}

let workerReducer = Reducer<WorkerState, WorkerAction, WorkerEnvironment> { state, action, _ in
    switch action {
    case .goToPulseView(let isActive):
        state.isActivePulseView = isActive
        return .none

    case .goToEndOfWorkView(let isActive):
        state.isActiveEndOfWorkView = isActive
        return .none

    case .onAppear:
        return .concatenate(
            Effect(value: .checkAccount),
            Effect(value: .setWorkerData),
            Effect(value: .getTerminalIdFromUserDefaults)
        )

    case .checkAccount:
        // TODO: staff、worker側は正しいQRコードを読み取り次第、アニノマスログインを行う。
        return .none

    case .login:
        return .none

    case .logout:
        return .none

        // workerのデータを設定。mode、terminalIdなど
    case .setWorkerData:
        return .none

    case .getTerminalIdFromUserDefaults:
        return .none
    }
}
