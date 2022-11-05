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
    var isLogedIn = false
    var isShowingQrReader = false
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
    case goToPulseView(Bool)
    case goToEndOfWorkView(Bool)
    case onAppear
    case goToQrCodeView(Bool)
    case scanQrCodeResult(result: String)
    case readOwnerAuthUid
    case readWorkerId
    case checkAccount
    case login
    case logout
    case setWorkerData
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
            Effect(value: .setWorkerData)
        )

    case .goToQrCodeView(let isActive):
        state.isShowingQrReader = isActive
        return .none

    case .scanQrCodeResult(let result):
        print("hirohiro_resultAA: ", result)
        // ownerと同じならば
        // workerと同じならば
        return .none

    case .readOwnerAuthUid:
        // TODO: ownerはQRコードの前にownerなどをつけて、string切り離しをおこなって登録
        // hasReadOwnerAuthIdを更新
        state.hasReadOwnerAuthId = true
        // userdefalutsで保存
        return .none

    case .readWorkerId:
        // TODO: workerIDはworker + ランダム生成を使って用意する。
        state.hasReadWorkerId = true
        // userdefalutsで保存
        return .none

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
    }
}
