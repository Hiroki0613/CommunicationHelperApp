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
}

enum OwnerTopAction {
    case setPressure(String)
}

struct OwnerTopEnvironment {
}

let ownerTopReducer = Reducer<OwnerTopState, OwnerTopAction, OwnerTopEnvironment> { state, action, _ in
    switch action {
    case .setPressure(let pressureString):
        state.pressureString = pressureString
        return .none
    }
}
