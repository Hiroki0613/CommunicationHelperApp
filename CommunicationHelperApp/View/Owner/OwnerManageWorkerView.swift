//
//  OwnerManageWorkerView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/16.
//

import ComposableArchitecture
import SwiftUI

struct OwnerManageWorkerView: View {
    let viewStore: ViewStore<OwnerTopState, OwnerTopAction>

    var body: some View {
        List {
            Section("作業者") {
                Text("ヤマダさん\n平均心拍数: 60\n 特徴\n　少し落ち着きが無いところがある\n")
                Text("スズキさん\n平均心拍数: 70\n 特徴\n　いつもご機嫌である\n")
                Text("サトウさん\n平均心拍数: 80\n 特徴\n　耳が聞こえづらいので近くで声をかけてあげて\n")
                Text("エンドウさん\n平均心拍数: 70\n 特徴\n　釣りの趣味があって、話を振ってあげると喜ぶ\n")
            }
        }
    }
}

struct OwnerManageWorkerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManageStaffView()
    }
}
