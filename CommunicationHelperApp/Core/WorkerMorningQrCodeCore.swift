//
//  WorkerMorningQrCodeCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/11.
//

import ComposableArchitecture
import Foundation

struct WorkerMorningQrCodeState: Equatable {
    var terminalId = ""
    // push通知などでデータを受け取り、TopCore等で捕まえて、ここまで落として処理を開始する?
    // いや、snapShotListenerでlistenするほうが良いか？
    var hasReadQrCodeFromStaff = false
}

enum WorkerMorningQrCodeAction {
    case showQrCode
    case checkReadByStaff
    case fetchFromData
    case goToWorkerMode
}

struct WorkerMorningQrCodeEnvironment {
}

let workerMorningQrCodeReducer = Reducer<WorkerMorningQrCodeState, WorkerMorningQrCodeAction, WorkerMorningQrCodeEnvironment> { _ ,action, _ in
    switch action {
    case .showQrCode:
        return .none

    case .checkReadByStaff:
        return .none

    case .fetchFromData:
        return .none

    case .goToWorkerMode:
        return .none
    }
}
