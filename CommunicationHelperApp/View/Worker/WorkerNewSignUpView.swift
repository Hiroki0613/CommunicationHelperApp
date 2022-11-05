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
                        viewStore.send(.goToQrCodeView(true))
                }, label: {
                    VStack {
                        Text("カメラ起動")
                        Image(systemName: "camera")
                    }
                    .foregroundColor(Color.black)
                    .frame(width: 164, height: 155)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                })
                .fullScreenCover(
                    isPresented: viewStore.binding(
                        get: \.isShowingQrReader,
                        send: WorkerAction.goToQrCodeView
                    )
                ) {
                    QRCameraView(viewStore: viewStore)
                }
            }
        }
    }
}

struct QRCameraView: View {
    let viewStore: ViewStore<WorkerState, WorkerAction>

    var body: some View {
        ZStack {
            QrCodeScannerView()
                .found(read: { result in
                    // TODO: ここでOwnerのAuthUidとWorkerのUidを読み取る。
                    // TODO: QRコードを読み取り、UserDefaultsで保存。
                    viewStore.send(.scanQrCodeResult(result: result))
                })
                .interval(delay: viewStore.scanInterval)
            VStack {
                VStack {
                    Spacer().frame(height: 40)
                    Text("QRコードを読み込んでください")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(PrimaryColor.buttonColor)
                        .cornerRadius(20)
                        .padding(.horizontal, 22)
                    // TODO: Owner + workerを読み込んだら、つどつどUIに表示させる。
                    Spacer()
                    Button(action: {
                        viewStore.send(.goToQrCodeView(false))
                    }, label: {
                        Text("閉じる")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 92)
                            .background(PrimaryColor.buttonColor)
                            .cornerRadius(20)
                            .padding(.horizontal, 22)
                    })
                    Spacer().frame(height: 30)
                }
                .padding(.vertical, 20)
                Spacer()
            }
            .padding()
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
