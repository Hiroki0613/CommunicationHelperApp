//
//  WorkerQrScanCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/05.
//

import ComposableArchitecture
import Foundation

struct WorkerQrScanState: Equatable {
    var hasReadOwnerAuthId = false
    var hasReadWorkerId = false
}

enum WorkerQrScanAction {
    case scanQrCodeResult(result: String)
    case readOwnerAuthUid
    case readWorkerId
    case finishReadQrCode
}

struct WorkerQrScanEnvironment {
}

let workerQrScanReducer = Reducer<WorkerQrScanState, WorkerQrScanAction, WorkerQrScanEnvironment> { state, action, _ in
    switch action {
    case .scanQrCodeResult(let result):
        print("hirohiro_resultAA: ", result)
        if result.contains("ownerFirebaseUid") {
            return .concatenate(
                Effect(value: .readOwnerAuthUid)
            )
        }
        if result.contains("workerUUID") {
            return .concatenate(
                Effect(value: .readWorkerId)
            )
        }
        return .none

    case .readOwnerAuthUid:
        // TODO: ownerはQRコードの前にownerなどをつけて、string切り離しをおこなって登録
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
            return .none
        }
        return .none
    }
}
