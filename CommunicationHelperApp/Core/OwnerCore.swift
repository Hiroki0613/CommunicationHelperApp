//
//  OwnerCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/05.
//

import ComposableArchitecture
import Foundation

struct OwnerState: Equatable {
    var pressureString = ""
}

enum OwnerAction {
    case setPressure(String)
}

struct OwnerEnvironment {
}

let ownerReducer = Reducer<OwnerState, OwnerAction, OwnerEnvironment> { state, action, _ in
    switch action {
    case .setPressure(let pressureString):
        state.pressureString = pressureString
        print("hirohiro_pressureStringaaa: ", state.pressureString)
        return .none
    }
}
