//
//  WorkerCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/29.
//

import ComposableArchitecture

struct WorkerState: Equatable {

}

enum WorkerAction {
    // TODO: 理想はFirebaseの処理はenvironmentから行うのが良いが、今回はaction+別modelでfuncを用意する方向にする。
}

struct WorkerEnvironment {

}

let workerReducer = Reducer<WorkerState, WorkerAction, WorkerEnvironment> { state, action, _ in
    switch action {

    }
}
