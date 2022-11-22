//
//  OwnerSettingView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/16.
//

import ComposableArchitecture
import CoreMotion
import SwiftUI

struct OwnerSettingView: View {

    let viewStore: ViewStore<OwnerTopState, OwnerTopAction>

    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                ZStack {
                    Rectangle()
                        .fill(PrimaryColor.buttonColor)
                        .frame(width: 303, height: 272)
                        .cornerRadius(20)
                    VStack {
                        HStack {
                            Spacer().frame(width: 34)
                            Text("支援者")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .foregroundColor(Color.black)
                                .frame(width: 303, height: 30, alignment: .leading)
                        }
                        HStack {
                            Text("開始　０：００")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .foregroundColor(Color.black)
                                .frame(width: 303, height: 30, alignment: .trailing)
                            Spacer().frame(width: 20)
                        }
                        HStack {
                            Text("終了　０：００")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .foregroundColor(Color.black)
                                .frame(width: 303, height: 30, alignment: .trailing)
                            Spacer().frame(width: 20)
                        }
                    }
                }
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
                        .padding(.horizontal, 22)
                })
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
        OwnerManageWorkerView(
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
