//
//  OwnerCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/05.
//

import ComposableArchitecture
import Foundation

struct OwnerTopState: Equatable {
    var pressureString = ""
    var hasRegistrated = false
    var hasShowedQrCode = false
}

enum OwnerTopAction {
    case setPressure(String)
    case registratedByEmailAndPassword(Bool)
    case gotoQrCodeCreateView(Bool)
}

struct OwnerTopEnvironment {
}

let ownerTopReducer = Reducer<OwnerTopState, OwnerTopAction, OwnerTopEnvironment> { state, action, _ in
    switch action {
    case .setPressure(let pressureString):
        state.pressureString = pressureString
        return .none

    case .registratedByEmailAndPassword(let hasRegistrated):
        state.hasRegistrated = hasRegistrated
        return .none

    case .gotoQrCodeCreateView(let isActive):
        state.hasShowedQrCode = isActive
        return .none
    }
}
