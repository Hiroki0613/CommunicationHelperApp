//
//  TopCore.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/18.
//

import ComposableArchitecture

struct TopState: Equatable {
    
}

enum TopAction {
    // TODO: 理想はFirebaseの処理はenvironmentから行うのが良いが、今回はaction+別modelでfuncを用意する方向にする。
}

struct TopEnvironment {
    
}

let topReducer = Reducer<TopState, TopAction, TopEnvironment> { state, action, _ in
    switch action {
        
    }
}
