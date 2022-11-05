//
//  WorkerCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/29.
//

import ComposableArchitecture
import Foundation

struct WorkerState: Equatable {
    let scanInterval = 1.0
    var workerQrScanState = WorkerQrScanState()
    var isLogedIn = false
    var isShowingOwnerQrReader = false
    var isShowingWorkerQrReader = false
    var hasReadOwnerAuthId = false
    var hasReadWorkerId = false
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
    case workerQrScanAction(WorkerQrScanAction)
    case goToPulseView(Bool)
    case goToEndOfWorkView(Bool)
    case onAppear
//    case goToNewSignInView(Bool)
    case goToOwnerQrCodeView(Bool)
    case goToWorkerQrCodeView(Bool)
    case scanQrCodeResult(type: ReadType, result: String)
    case readOwnerAuthUid
    case readWorkerId
    case finishReadQrCode
    case checkAccount
    case login
    case logout
    case setWorkerData
}

struct WorkerEnvironment {
    var workerQrScanEnvironment: WorkerQrScanEnvironment {
        .init()
    }
}

let workerReducer = Reducer<WorkerState, WorkerAction, WorkerEnvironment>.combine(
    workerQrScanReducer.pullback(
        state: \.workerQrScanState,
        action: /WorkerAction.workerQrScanAction,
        environment: \.workerQrScanEnvironment
    ),
    Reducer<WorkerState, WorkerAction, WorkerEnvironment> { state, action, _ in
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
                Effect(value: .setWorkerData)
            )

//        case .goToNewSignInView(let isActive):
//            // TopCoreで処理
//            return .none

        case .goToOwnerQrCodeView(let isActive):
            state.isShowingOwnerQrReader = isActive
            return .none

        case .goToWorkerQrCodeView(let isActive):
            state.isShowingWorkerQrReader = isActive
            return .none

        case .scanQrCodeResult(let readType, let result):
            print("hirohiro_resultAA: ", result)
            switch readType {
            case .owner:
                if result.contains("ownerFirebaseUid") {
                    return .concatenate(
                        Effect(value: .goToOwnerQrCodeView(false)),
                        Effect(value: .readOwnerAuthUid)
                    )
                }
            case .worker:
                if result.contains("workerUUID") {
                    return .concatenate(
                        Effect(value: .goToWorkerQrCodeView(false)),
                        Effect(value: .readWorkerId)
                    )
                }
            }
            return .none

        case .readOwnerAuthUid:
            // TODO: ownerはQRコードの前にownerなどをつけて、string切り離しをおこなって登録
            // hasReadOwnerAuthIdを更新
            state.hasReadOwnerAuthId = true
            print("hirohiro_ownerID読んだ！")
            // userdefalutsで保存
            return Effect(value: .finishReadQrCode)

        case .readWorkerId:
            // TODO: workerIDはworker + ランダム生成を使って用意する。
            state.hasReadWorkerId = true
            print("hirohiro_workerID読んだ！")
            // userdefalutsで保存
            return Effect(value: .finishReadQrCode)

        case .finishReadQrCode:
            // TODO: ここでもUserDefaultsがきちんと読み込めているかも確認した方が良さそう
            if state.hasReadOwnerAuthId && state.hasReadWorkerId {
                print("hirohiro_完了した")
                state.hasReadOwnerAuthId = false
                state.hasReadWorkerId = false
                state.mode = .startOfWork
                return Effect(value: .login)
            }
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
