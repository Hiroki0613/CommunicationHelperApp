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
//    var workerChatTopState = WorkerChatTopState()
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
//    case workerChatTopAction(WorkerChatTopAction)
    case goToPulseView(Bool)
    case goToEndOfWorkView(Bool)
    case onAppear
    case goToNewSignInView(Bool)
    case goToQrCodeView(Bool)
    case checkAccount
    case login
    case logout
    case setWorkerData
    case changeView(Mode)
}

struct WorkerTopEnvironment {
    var workerNewRegistrationQrScanEnvironment: WorkerNewRegistrationQrScanEnvironment {
        .init()
    }
    var workerMorningQrCodeEnvironment: WorkerMorningQrCodeEnvironment {
        .init()
    }
//    var workerChatTopEnvironment: WorkerChatTopEnvironMent {
//        .init()
//    }
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
//    workerChatTopReducer.pullback(
//        state: \.workerChatTopState,
//        action: /WorkerTopAction.workerChatTopAction,
//        environment: \.workerChatTopEnvironment
//    ),
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

//        case .workerChatTopAction:
//            return .none

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
            return .none

        case .logout:
            return .none

        case .setWorkerData:
            return .none

        case .changeView(let mode):
            state.mode = mode
            return .none
        }
    }
)
