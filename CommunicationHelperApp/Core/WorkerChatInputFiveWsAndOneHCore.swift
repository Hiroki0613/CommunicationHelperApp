//
//  WorkerChatInputFiveWsAndOneHCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/20.
//

import ComposableArchitecture
import Foundation

struct WorkerChatInputFiveWsAndOneHState: Equatable {
//    var allString = ""
//    var hasInputWho = false
//    var hasInputWhat = false
//    var hasInputWhen = false
//    var hasInputWhy = false
//    var hasInputHow = false
//    var showSendTextButton = false
}

enum WorkerChatInputFiveWsAndOneHAction {
//    case afterInputWhere
//    case afterInputWho
//    case afterInputWhat
//    case afterInputWhen
//    case afterInputWhy
//    case afterInputHow
//    case getAllString(whereText: String, whoText: String, whatText: String, whenText: String, whyText: String, howText: String)
}

struct WorkerChatInputFiveWsAndOneHEnvironment {
}

let workerChatInputFiveWsAndOneHReducer = Reducer<WorkerChatInputFiveWsAndOneHState, WorkerChatInputFiveWsAndOneHAction, WorkerChatInputFiveWsAndOneHEnvironment> { state, action, _ in
    switch action {
//    case .afterInputWhere:
//        state.hasInputWho = true
//        return .none
//
//    case .afterInputWho:
//        state.hasInputWhat = true
//        return .none
//
//    case .afterInputWhat:
//        state.hasInputWhen = true
//        return .none
//
//    case .afterInputWhen:
//        state.hasInputWhy = true
//        return .none
//
//    case .afterInputWhy:
//        state.hasInputHow = true
//        return .none
//
//    case .afterInputHow:
//        // ここで送信ボタンを押せるようにする。
//        return .none
//
//    case let .getAllString(whereText, whoText, whatText, whenText, whyText, howText ):
//        var allString = whereText + "で" + whoText + "が" + whatText + "を" + whenText + "に" + whyText + howText
//        state.allString = allString
//        print("hirohiro_allString: ", state.allString)
//        return .none
    }
}
