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
                TabView {
                    // TODO: 画面には出さないが、端末管理は無制限に登録させる。作業者のみを課金制にする。
                    /*
                     ・端末追加はworker側がQRコードを読み込んで保存。
                     ・UserDefaultsに情報を保存して、朝礼時にその端末QRコードを表示するようにする。
                     ・WorkerQRコードはOwner側で生成して、画像 or PDFで読み出しをできるようにする。それを朝礼時に読み込み
                     ・Firebaseのログイン有無はKeyChainが関わってくるので慎重に行うこと。対策をせずに、迂闊にアプリを消すとクラッシュの原因になる。
                     ・チャットはOwnerのUUID直下に置くようにする。チャットルームは、独立させる。ただし、Workerとは紐付けをしておいて該当のチャットルームを出すようにする。
                     ・出勤、不在が一目でわかるようにすると良さそう。
                     ・オーナー側の作業者の削除機能はどうする？名前を変えて、そのまま使い続けるのも構わない。
                     */
                    OwnerSettingTopView(viewStore: viewStore)
                        .tabItem {
                            Label("設定", systemImage: "gear")
                        }
                    OwnerManageStaffTopView()
                        .tabItem {
                            Label("スタッフ", systemImage: "person")
                        }
                    OwnerManageWorkerTopView(viewStore: viewStore)
                        .tabItem {
                            Label("作業者", systemImage: "hammer.fill")
                        }
                }
                .navigationBarBackButtonHidden(true)
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
