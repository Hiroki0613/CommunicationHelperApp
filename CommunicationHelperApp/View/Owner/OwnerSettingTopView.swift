//
//  OwnerSettingTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/16.
//

import ComposableArchitecture
import CoreMotion
import SwiftUI

struct OwnerSettingTopView: View {

    let viewStore: ViewStore<OwnerTopState, OwnerTopAction>

    var body: some View {
        ZStack {
            PrimaryColor.background
            ScrollView {
                VStack {
                    Spacer().frame(height: 20)
                    OwnerSettingOperatingTimeView(startTime: "8:30", endTime: "17:30")
                        .cornerRadius(20)
                    Spacer().frame(height: 30)
                    OwnerSettingPressureView(viewStore: viewStore)
                        .cornerRadius(20)
                    Spacer().frame(height: 30)
                    OwnerSettingsubscriptionView()
                        .cornerRadius(20)
                    Spacer().frame(height: 30)
                    Button(action: {
                        viewStore.send(.gotoQrCodeCreateView(true))
                    }, label: {
                        Text("Workerの追加")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 91)
                            .background(PrimaryColor.buttonRedColor)
                            .cornerRadius(20)
                    })
                }
                .padding(.horizontal, 30)
            }
            .fullScreenCover(
                isPresented: viewStore.binding(
                    get: \.hasShowedQrCode,
                    send: OwnerTopAction.gotoQrCodeCreateView
                )) {
                    OwnerQRCodeView()
                }
        }
    }
}

struct OwnerSettingView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManageWorkerTopView(
            viewStore: ViewStore(
                Store(
                    initialState: OwnerTopState(),
                    reducer: ownerTopReducer,
                    environment: OwnerTopEnvironment()
                )
            )
        )
    }
}
