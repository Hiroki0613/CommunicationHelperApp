//
//  OwnerTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/16.
//

import ComposableArchitecture
import SwiftUI

struct OwnerTopView: View {
    let store: Store<OwnerTopState, OwnerTopAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            if viewStore.hasRegistrated {
                ZStack {
                    TabView {
                        OwnerSettingView(viewStore: viewStore)
                            .tabItem {
                                Label("設定", systemImage: "gear")
                            }
                        OwnerManageStaffView()
                            .tabItem {
                                Label("スタッフ", systemImage: "person")
                            }
                        OwnerManageWorkerView(viewStore: viewStore)
                            .tabItem {
                                Label("スタッフ", systemImage: "hammer.fill")
                            }
                    }
                }
            } else {
                OwnerLoginView(viewStore: viewStore)
            }
        }
    }
}

struct OwnerTopView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerTopView(
            store: Store(
                initialState: OwnerTopState(),
                reducer: ownerTopReducer,
                environment: OwnerTopEnvironment()
            )
        )
    }
}
