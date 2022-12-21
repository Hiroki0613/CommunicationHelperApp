//
//  WorkerChatInputFiveWsAndOneHCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/20.
//

import ComposableArchitecture
import Foundation

struct WorkerChatInputFiveWsAndOneHState: Equatable {
    var whereText = ""
    var whoText = ""
    var whatText = ""
    var whenText = ""
    var whyText = ""
    var howText = ""
    var hasInputWhere = false
    var hasInputWho = false
    var hasInputWhat = false
    var hasInputWhen = false
    var hasInputWhy = false
    var hasInputHow = false
}

enum WorkerChatInputFiveWsAndOneHAction {
    case inputWhere(String)
    case inputWho(String)
    case inputWhat(String)
    case inputWhen(String)
    case inputWhy(String)
    case inputHow(String)
}

struct WorkerChatInputFiveWsAndOneHEnvironment {
}

let workerChatInputFiveWsAndOneHReducer = Reducer<WorkerChatInputFiveWsAndOneHState, WorkerChatInputFiveWsAndOneHAction, WorkerChatInputFiveWsAndOneHEnvironment> { state, action, _ in
    switch action {
    case .inputWhere:
        state.hasInputWhere = true
        return .none

    case .inputWho:
        state.hasInputWho = true
        return .none

    case .inputWhat:
        state.hasInputWhat = true
        return .none

    case .inputWhen:
        state.hasInputWhen = true
        return .none

    case .inputWhy:
        state.hasInputWhy = true
        return .none

    case .inputHow:
        state.hasInputHow = true
        return .none
    }
}
