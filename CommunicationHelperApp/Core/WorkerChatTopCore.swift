//
//  WorkerChatTopCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/24.
//

import ComposableArchitecture
import Foundation

struct WorkerChatTopState: Equatable {
    var workerChatInputFiveWsAndOneHState = WorkerChatInputFiveWsAndOneHState()
}

enum WorkerChatTopAction {
    case workerChatInputFiveWsAndOneHAction(WorkerChatInputFiveWsAndOneHAction)

}

struct WorkerChatTopEnvironMent {
    var workerChatInputFiveWsAndOneHEnvironment: WorkerChatInputFiveWsAndOneHEnvironment {
        .init()
    }
}

let workerChatTopReducer = Reducer<WorkerChatTopState, WorkerChatTopAction, WorkerChatTopEnvironMent>.combine(
    workerChatInputFiveWsAndOneHReducer.pullback(
        state: \.workerChatInputFiveWsAndOneHState,
        action: /WorkerChatTopAction.workerChatInputFiveWsAndOneHAction,
        environment: \.workerChatInputFiveWsAndOneHEnvironment
    ),
    Reducer<WorkerChatTopState, WorkerChatTopAction, WorkerChatTopEnvironMent> { _, action, _ in
        switch action {
        case .workerChatInputFiveWsAndOneHAction:
            return .none
        }
    }
)
