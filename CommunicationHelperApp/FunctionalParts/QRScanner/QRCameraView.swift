//
//  QRCameraView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/05.
//

import ComposableArchitecture
import SwiftUI

enum ReadType {
    case owner
    case worker
}

struct QRCameraView: View {
    let readType: ReadType
    let viewStore: ViewStore<WorkerState, WorkerAction>

    var body: some View {
        ZStack {
//            QrCodeScannerView()
//                .found(read: { result in
//                    viewStore.send(.scanQrCodeResult(type: readType, result: result))
//                })
//                .interval(delay: viewStore.scanInterval)
            QrCodeScannerView(viewStore: viewStore)
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

struct QRCameraView_Previews: PreviewProvider {
    static var previews: some View {
        QRCameraView(
            readType: .owner,
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
