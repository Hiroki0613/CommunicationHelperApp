//
//  WorkerCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/29.
//

import ComposableArchitecture
import Foundation

struct WorkerTopState: Equatable {
    var workerQrScanState = WorkerQrScanState()
    // firebaseAuthLogin
    var isLogedIn = false
    var isShowingQrReader = false
    var mode: Mode = .startOfWork
    var isActivePulseView = false
    var isActiveEndOfWorkView = false
    // デフォルトで8時30分
    var startTime: Date?
    // デフォルトで17時30分
    var endTime: Date?
    var terminalId = ""
}

enum WorkerTopAction {
    case workerQrScanAction(WorkerQrScanAction)
    case goToPulseView(Bool)
    case goToEndOfWorkView(Bool)
    case onAppear
    case goToNewSignInView(Bool)
    case goToQrCodeView(Bool)
    case checkAccount
    case login
    case logout
    case setWorkerData
}

struct WorkerTopEnvironment {
    var workerQrScanEnvironment: WorkerQrScanEnvironment {
        .init()
    }
}

let workerReducer = Reducer<WorkerTopState, WorkerTopAction, WorkerTopEnvironment>.combine(
    workerQrScanReducer.pullback(
        state: \.workerQrScanState,
        action: /WorkerTopAction.workerQrScanAction,
        environment: \.workerQrScanEnvironment
    ),
    Reducer<WorkerTopState, WorkerTopAction, WorkerTopEnvironment> { state, action, _ in
        switch action {
        case .workerQrScanAction(.firstLogin):
            state.mode = .startOfWork
            return .concatenate(
                Effect(value: .goToQrCodeView(false)),
                Effect(value: .login)
            )

        case .workerQrScanAction:
            return .none

        case .goToPulseView(let isActive):
            state.isActivePulseView = isActive
            return .none

        case .goToEndOfWorkView(let isActive):
            state.isActiveEndOfWorkView = isActive
            return .none

        case .onAppear:
            return .concatenate(
                Effect(value: .checkAccount),
                Effect(value: .setWorkerData)
            )

        case .goToNewSignInView:
            // TopCoreで処理
            return .none

        case .goToQrCodeView(let isActive):
            state.isShowingQrReader = isActive
            return .none

        case .checkAccount:
            return .none

        case .login:
            // TODO: staff、worker側は正しいQRコードを読み取り次第、アニノマスログインを行う。
            state.isLogedIn = true
            return .none

        case .logout:
            return .none

            // workerのデータを設定。mode、terminalIdなど
        case .setWorkerData:
            return .none
        }
    }
)