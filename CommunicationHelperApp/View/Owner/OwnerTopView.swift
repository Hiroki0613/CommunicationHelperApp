//
//  OwnerTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/16.
//

import SwiftUI

struct OwnerTopView: View {
    var body: some View {
        TabView {
            OwnerManageWorkerView()
                .tabItem {
                    Label("作業者", systemImage: "hammer.fill")
                }
            OwnerManageStaffView()
                .tabItem {
                    Label("スタッフ", systemImage: "person")
                }
            OwnerSettingView()
                .tabItem {
                    Label("設定", systemImage: "gear")
                }
        }
        // TODO: トップ画面ではなく、OwnerTopViewでアカウントログインをする。フルスクリーンカバーを使う。
    }
}

struct OwnerTopView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerTopView()
    }
}
