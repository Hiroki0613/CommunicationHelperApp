//
//  TestOwnerView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/05.
//

import ComposableArchitecture
import SwiftUI

struct TestOwnerView: View {
    let store: Store<OwnerTopState, OwnerTopAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                PrimaryColor.background
                ScrollView {
                    VStack {
                        Spacer().frame(height: 80)
                        Text("デバッグ画面")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                        NavigationLink(
                            destination: {
                                PressureView(viewStore: viewStore)
                            },
                            label: {
                                Text("気圧計")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(PrimaryColor.buttonColor)
                                    .padding(.horizontal, 22)
                            }
                        )
                        Spacer().frame(height: 20)
                    }
                }
            }

        }
    }
}

struct TestOwnerView_Previews: PreviewProvider {
    static var previews: some View {
        TestOwnerView(
            store: Store(
                initialState: OwnerTopState(),
                reducer: ownerTopReducer,
                environment: OwnerTopEnvironment()
            )
        )
    }
}
