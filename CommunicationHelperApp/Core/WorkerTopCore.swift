//
//  WorkerCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/29.
//

import ComposableArchitecture
import Foundation

struct WorkerTopState: Equatable {
    var workerNewRegistrationQrScanState = WorkerNewRegistrationQrScanState()
    var workerMorningQrCodeState = WorkerMorningQrCodeState()
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
    case workerNewRegistrationQrScanAction(WorkerNewRegistrationQrScanAction)
    case workerMorningQrCodeAction(WorkerMorningQrCodeAction)
    case goToPulseView(Bool)
    case goToEndOfWorkView(Bool)
    case onAppear
    case goToNewSignInView(Bool)
    case goToQrCodeView(Bool)
    case checkAccount
    case login
    case logout
    case setWorkerData
    case testChangeView(Mode)
}

struct WorkerTopEnvironment {
    var workerNewRegistrationQrScanEnvironment: WorkerNewRegistrationQrScanEnvironment {
        .init()
    }
    var workerMorningQrCodeEnvironment: WorkerMorningQrCodeEnvironment {
        .init()
    }
}

let workerTopReducer = Reducer<WorkerTopState, WorkerTopAction, WorkerTopEnvironment>.combine(
    workerNewRegistrationQrScanReducer.pullback(
        state: \.workerNewRegistrationQrScanState,
        action: /WorkerTopAction.workerNewRegistrationQrScanAction,
        environment: \.workerNewRegistrationQrScanEnvironment
    ),
    workerMorningQrCodeReducer.pullback(
        state: \.workerMorningQrCodeState,
        action: /WorkerTopAction.workerMorningQrCodeAction,
        environment: \.workerMorningQrCodeEnvironment
    ),
    Reducer<WorkerTopState, WorkerTopAction, WorkerTopEnvironment> { state, action, _ in
        switch action {
        case .workerNewRegistrationQrScanAction(.firstLogin):
            state.mode = .startOfWork
            return .concatenate(
                Effect(value: .goToQrCodeView(false)),
                Effect(value: .login)
            )

        case .workerNewRegistrationQrScanAction:
            return .none

        case .workerMorningQrCodeAction:
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

        case .testChangeView(let mode):
            state.mode = mode
            return .none
        }
    }
)
