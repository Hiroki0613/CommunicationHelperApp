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
    var hasReadDeviceId = false
}

enum WorkerNewRegistrationQrScanAction {
    case scanQrCodeResult(result: String)
    case readOfficeAuthUid(id: String)
    case readDeviceId(id: String)
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
        if result.contains("owner_") {
            return .concatenate(
                Effect(value: .readOfficeAuthUid(id: result))
            )
        }
        if result.contains("device_") {
            return .concatenate(
                Effect(value: .readDeviceId(id: result))
            )
        }
        return .none

    case .readOfficeAuthUid(let id):
        // "owner_"のstringだけを取り除く。
        var ownerId = id.replacingOccurrences(of: "owner_", with: "")
        state.hasReadOfficeAuthId = true
        userDefault.ownerId = ownerId
        return Effect(value: .finishReadQrCode)

    case .readDeviceId(let id):
        state.hasReadDeviceId = true
        userDefault.deviceId = id
        return Effect(value: .finishReadQrCode)

    case .finishReadQrCode:
        if userDefault.deviceId != nil
            && userDefault.ownerId != nil
            && state.hasReadOfficeAuthId
            && state.hasReadDeviceId {
            print("hirohiro_完了した")
            userDefault.hasLogin = true
            state.hasReadOfficeAuthId = false
            state.hasReadDeviceId = false
            return Effect(value: .firstLogin)
            // TODO: QRコードを読み込んだ時についでに行うこと。　匿名ログインでも問題が無いかは要確認。
            /*
             　1. 同時にFirebaseでデータを作成。そのときにFCMトークン欄も作成しておくこと。
             　2. FCMトークンは朝の調整時に毎回、データを入れ替える。そのことで、トークンが入れ替わっていたら再セットをしなおす。
             　3. FCMトークンはPush通知で使うために用意する。これが匿名ログインでも効果を発揮したら万歳である。
             　4. kavsoftの動画を参考にサンプルアプリで確認してみる。
             */
        }
        return .none

    case .firstLogin:
        // WorkerCoreで処理
        return .none
    }
}
