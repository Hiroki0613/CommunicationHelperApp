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
                        viewStore.send(.goToOwnerQrCodeView(true))
                }, label: {
                    VStack {
                        Text("カメラ起動\nオーナー側")
                        Image(systemName: "camera")
                    }
                    .foregroundColor(Color.black)
                    .frame(width: 200, height: 200)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                    .opacity(viewStore.hasReadOwnerAuthId ? 0.2 : 1.0)
                })
                Spacer().frame(height: 40)
                Button(
                    action: {
                        viewStore.send(.goToWorkerQrCodeView(true))
                }, label: {
                    VStack {
                        Text("カメラ起動\n作業者側")
                        Image(systemName: "camera")
                    }
                    .foregroundColor(Color.black)
                    .frame(width: 200, height: 200)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                    .opacity(viewStore.hasReadWorkerId ? 0.2 : 1.0)
                })
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

enum ReadType {
    case owner
    case worker
}

struct QRCameraView: View {
    let readType: ReadType
    let viewStore: ViewStore<WorkerState, WorkerAction>

    var body: some View {
        ZStack {
            QrCodeScannerView()
                .found(read: { result in
                    viewStore.send(.scanQrCodeResult(type: readType, result: result))
                })
                .interval(delay: viewStore.scanInterval)
            VStack {
                VStack {
                    Spacer().frame(height: 40)
                    // TODO: オーナー側と作業者側で表示文字を変更する
                    Text("QRコードを読み込んでください")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(PrimaryColor.buttonColor)
                        .cornerRadius(20)
                        .padding(.horizontal, 22)
                    Spacer()
                    Button(action: {
                        switch readType {
                        case .owner:
                            viewStore.send(.goToOwnerQrCodeView(false))
                        case .worker:
                            viewStore.send(.goToWorkerQrCodeView(false))
                        }
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
