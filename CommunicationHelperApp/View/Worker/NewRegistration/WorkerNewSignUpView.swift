//
//  WorkerNewSignUpView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/30.
//

import ComposableArchitecture
import SwiftUI

struct WorkerNewSignUpView: View {
    let store: Store<WorkerState, WorkerAction>
    var backToTopViewAction: () -> Void

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                PrimaryColor.background
                VStack {
                    Text("新規登録")
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    // 読み取ったQRコード表示位置
                    Button(
                        action: {
                            viewStore.send(.goToQrCodeView(true))
                        }, label: {
                            VStack {
                                Text("カメラ起動")
                                Image(systemName: "camera")
                            }
                            .foregroundColor(Color.black)
                            .frame(width: 200, height: 150)
                            .background(PrimaryColor.buttonColor)
                            .cornerRadius(20)
                        })
                    Spacer().frame(height: 80)
                    Button(
                        action: {
                            backToTopViewAction()
                        }, label: {
                            Text("戻る")
                                .foregroundColor(Color.black)
                                .frame(width: 200, height: 50)
                                .background(PrimaryColor.buttonColor)
                                .cornerRadius(20)
                        }
                    )
                    .fullScreenCover(
                        isPresented: viewStore.binding(
                            get: \.isShowingQrReader,
                            send: WorkerAction.goToQrCodeView
                        )
                    ) {
                        QRCameraView(
                            store: store.scope(
                                state: \.workerQrScanState,
                                action: WorkerAction.workerQrScanAction
                            ),
                            goBackAction: {
                                viewStore.send(.goToQrCodeView(false))
                            }
                        )
                    }
                }
            }
        }
    }
}

struct WorkerNewSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerNewSignUpView(
            store: Store(
                initialState: WorkerState(),
                reducer: workerReducer,
                environment: WorkerEnvironment()
            ),
            backToTopViewAction: { }
        )
    }
}
