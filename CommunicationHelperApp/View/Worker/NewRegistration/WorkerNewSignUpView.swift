//
//  WorkerNewSignUpView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/30.
//

import ComposableArchitecture
import SwiftUI

struct WorkerNewSignUpView: View {
    let viewStore: ViewStore<WorkerState, WorkerAction>
//    var buckToTopViewAction: () -> Void

    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Text("新規登録")
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                // 読み取ったQRコード表示位置
                Button(
                    action: {
                        viewStore.send(.goToOwnerQrCodeView(true))
                }, label: {
                    VStack {
                        Text("カメラ起動")
                        Image(systemName: "camera")
                    }
                    .foregroundColor(Color.black)
                    .frame(width: 200, height: 150)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                    .opacity(viewStore.hasReadOwnerAuthId ? 0.2 : 1.0)
                })
                Spacer().frame(height: 40)
//                Button(
//                    action: {
//                        viewStore.send(.goToNewSignInView(false))
//                    }, label: {
//                        Text("戻る")
//                            .foregroundColor(Color.black)
//                            .frame(width: 200, height: 50)
//                            .background(PrimaryColor.buttonColor)
//                            .cornerRadius(20)
//                    })
                .fullScreenCover(
                    isPresented: viewStore.binding(
                        get: \.isShowingOwnerQrReader,
                        send: WorkerAction.goToOwnerQrCodeView
                    )
                ) {
                    QRCameraView(readType: .owner, viewStore: viewStore)
                }
                .fullScreenCover(
                    isPresented: viewStore.binding(
                        get: \.isShowingWorkerQrReader,
                        send: WorkerAction.goToWorkerQrCodeView
                    )
                ) {
                    QRCameraView(readType: .worker, viewStore: viewStore)
                }
            }
        }
    }
}

struct WorkerNewSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerNewSignUpView(
            viewStore: ViewStore(
                Store(
                    initialState: WorkerState(),
                    reducer: workerReducer,
                    environment: WorkerEnvironment()
                )
            )
        )
    }
}
