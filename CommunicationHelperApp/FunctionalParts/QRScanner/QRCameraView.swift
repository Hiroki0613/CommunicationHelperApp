//
//  QRCameraView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/05.
//

import ComposableArchitecture
import SwiftUI

struct QRCameraView: View {
    let store: Store<WorkerQrScanState, WorkerQrScanAction>
    var goBackAction: () -> Void

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
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
                        if viewStore.hasReadWorkerId {
                            Spacer().frame(height: 20)
                            Text("作業者を読みました")
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                                .background(PrimaryColor.buttonColor)
                        }
                        if viewStore.hasReadOwnerAuthId {
                            Spacer().frame(height: 20)
                            Text("オーナーを読みました")
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                                .background(PrimaryColor.buttonColor)
                        }
                        Spacer()
                        Button(action: {
                            goBackAction()
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
}

struct QRCameraView_Previews: PreviewProvider {
    static var previews: some View {
        QRCameraView(
            store: Store(
                initialState: WorkerQrScanState(),
                reducer: workerQrScanReducer,
                environment: WorkerQrScanEnvironment()
            ),
            goBackAction: {}
        )
    }
}
