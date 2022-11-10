//
//  WorkerQrScanCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/05.
//

import ComposableArchitecture
import Foundation

struct WorkerQrScanState: Equatable {
    var hasReadOfficeAuthId = false
    var hasReadTerminalId = false
}

enum WorkerQrScanAction {
    case scanQrCodeResult(result: String)
    case readOfficeAuthUid(id: String)
    case readTerminalId(id: String)
    case finishReadQrCode
    case firstLogin
}

struct WorkerQrScanEnvironment {
}

let workerQrScanReducer = Reducer<WorkerQrScanState, WorkerQrScanAction, WorkerQrScanEnvironment> { state, action, _ in
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
        UserDefaults.standard.set(id, forKey: UserDefaultsString.officeId)
        // userdefalutsで保存
        return Effect(value: .finishReadQrCode)

    case .readTerminalId(let id):
        // TODO: workerIDはworker + ランダム生成を使って用意する。
        state.hasReadTerminalId = true
        UserDefaults.standard.set(id, forKey: UserDefaultsString.terminalId)
        return Effect(value: .finishReadQrCode)

    case .finishReadQrCode:
        if UserDefaults.standard.string(forKey: UserDefaultsString.terminalId) != nil
            && UserDefaults.standard.string(forKey: UserDefaultsString.officeId) != nil
            && state.hasReadOfficeAuthId
            && state.hasReadTerminalId {
            print("hirohiro_完了した")
            UserDefaults.standard.set(true, forKey: UserDefaultsString.hasLogin)
            print("hirohiro_user_officeId: ", UserDefaults.standard.string(forKey: UserDefaultsString.officeId))
            print("hirohiro_user_terminalId: ", UserDefaults.standard.string(forKey: UserDefaultsString.terminalId))
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
