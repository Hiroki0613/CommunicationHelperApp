//
//  TestView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import ComposableArchitecture
import SwiftUI

struct TestView: View {
    let store: Store<WorkerState, WorkerAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationLink(
                isActive: viewStore.binding(
                    get: \.isActivePulseView,
                    send: WorkerAction.setNavigationToPulseView
                ),
                destination: {
                    PulseView()
                },
                label: {
                    EmptyView()
                }
            )
            NavigationLink(
                isActive: viewStore.binding(
                    get: \.isActiveEndOfWorkView,
                    send: WorkerAction.setNavigationToEndOfWorkView
                ),
                destination: {
                    WorkerEndOfWorkQRCodeView()
                },
                label: {
                    EmptyView()
                }
            )
            ZStack {
                PrimaryColor.background
                ScrollView {
                    VStack {
                        Spacer().frame(height: 80)
                        Text("デバッグ画面")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                        Group {
                            NavigationLink(
                                destination: {
                                    WorkerNewSignUpView()
                                },
                                label: {
                                    Text("新規登録時\n(QRリーダー起動)")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        .background(PrimaryColor.buttonColor)
                                        .padding(.horizontal, 22)
                                }
                            )
                            Spacer().frame(height: 20)
                            NavigationLink(
                                destination: {
                                    WorkerQRCodeView()
                                },
                                label: {
                                    Text("朝の出勤時\nQRコードが出ます")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        .background(PrimaryColor.buttonColor)
                                        .padding(.horizontal, 22)
                                }
                            )
                            Spacer().frame(height: 20)
                            NavigationLink(
                                destination: {
                                    WorkerPulseTopView(action: {
                                        viewStore.send(.setNavigationToPulseView(true))
                                    })
                                },
                                label: {
                                    Text("心拍測定時\nパルスリーダー")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        .background(PrimaryColor.buttonColor)
                                        .padding(.horizontal, 22)
                                }
                            )
                            Spacer().frame(height: 20)
                            NavigationLink(
                                destination: {
                                    WorkerEndOfWorkTopView(action: {
                                        viewStore.send(.setNavigationToEndOfWorkView(true))
                                    })
                                },
                                label: {
                                    Text("退勤時")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        .background(PrimaryColor.buttonColor)
                                        .padding(.horizontal, 22)
                                }
                            )
                            Spacer().frame(height: 20)
                            NavigationLink(
                                destination: {
                                    PressureView()
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
                        }
                    }
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(
            store: Store(
                initialState: WorkerState(),
                reducer: workerReducer,
                environment: WorkerEnvironment()
            )
        )
    }
}
