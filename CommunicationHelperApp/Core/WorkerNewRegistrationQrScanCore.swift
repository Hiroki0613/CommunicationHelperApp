//
//  WorkerQrScanCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/05.
//

import ComposableArchitecture
import Foundation

struct WorkerNewRegistrationQrScanState: Equatable {
    var hasReadOfficeAuthId = false
    var hasReadTerminalId = false
}

enum WorkerNewRegistrationQrScanAction {
    case scanQrCodeResult(result: String)
    case readOfficeAuthUid(id: String)
    case readTerminalId(id: String)
    case finishReadQrCode
    case firstLogin
}

struct WorkerNewRegistrationQrScanEnvironment {
}

let workerNewRegistrationQrScanReducer = Reducer<WorkerNewRegistrationQrScanState, WorkerNewRegistrationQrScanAction, WorkerNewRegistrationQrScanEnvironment> { state, action, _ in
    var userDefault: UserDefaultDataStore = UserDefaultsDataStoreProvider.provide()

    switch action {
    case .scanQrCodeResult(let result):
        print("hirohiro_resultAA: ", result)
        if result.contains("ownerFirebaseUid") {
            return .concatenate(
                Effect(value: .readOfficeAuthUid(id: result))
            )
        }
        if result.contains("workerUUID") {
            return .concatenate(
                Effect(value: .readTerminalId(id: result))
            )
        }
        return .none

    case .readOfficeAuthUid(let id):
        // TODO: ownerはQRコードの前にownerなどをつけて、string切り離しをおこなって登録
        state.hasReadOfficeAuthId = true
        userDefault.officeId = id
        return Effect(value: .finishReadQrCode)

    case .readTerminalId(let id):
        // TODO: workerIDはworker + ランダム生成を使って用意する。
        state.hasReadTerminalId = true
        userDefault.terminalId = id
        return Effect(value: .finishReadQrCode)

    case .finishReadQrCode:
        if userDefault.terminalId != nil
            && userDefault.officeId != nil
            && state.hasReadOfficeAuthId
            && state.hasReadTerminalId {
            print("hirohiro_完了した")
            userDefault.hasLogin = true
            state.hasReadOfficeAuthId = false
            state.hasReadTerminalId = false
            return Effect(value: .firstLogin)
        }
        return .none

    case .firstLogin:
        // WorkerCoreで処理
        return .none
    }
}
