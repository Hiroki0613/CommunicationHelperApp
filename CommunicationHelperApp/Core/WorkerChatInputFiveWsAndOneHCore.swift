//
//  WorkerChatInputFiveWsAndOneHCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/20.
//

import ComposableArchitecture
import Foundation

struct WorkerChatInputFiveWsAndOneHState: Equatable {
    var hasInputWhere = false
    var hasInputWho = false
    var hasInputWhat = false
    var hasInputWhen = false
    var hasInputWhy = false
    var hasInputHow = false
}

enum WorkerChatInputFiveWsAndOneHAction {
    case checkInputWhere
    case checkInputWho
    case checkInputWhat
    case checkInputWhen
    case checkInputWhy
    case checkInputHow
}

struct WorkerChatInputFiveWsAndOneHEnvironment {
}

let workerChatInputFiveWsAndOneHReducer = Reducer<WorkerChatInputFiveWsAndOneHState, WorkerChatInputFiveWsAndOneHAction, WorkerChatInputFiveWsAndOneHEnvironment> { state, action, _ in
    switch action {
    case .checkInputWhere:
        return .none

    case .checkInputWho:
        return .none

    case .checkInputWhat:
        return .none

    case .checkInputWhen:
        return .none

    case .checkInputWhy:
        return .none

    case .checkInputHow:
        return .none
    }
}
