//
//  WorkerChatTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import ComposableArchitecture
import SwiftUI

struct WorkerChatTopView: View {
//    let store: Store<WorkerChatTopState, WorkerChatTopAction>
    @State private var isWorkerChatTopViewActive: Bool = false
    @StateObject var messagesManager = MessagesManager()
    var userDefault: UserDefaultDataStore = UserDefaultsDataStoreProvider.provide()

    var body: some View {
        VStack {
            VStack {
//                ChatTitleRow()
                ScrollViewReader { proxy in
                    ScrollView {
                        // TODO: ここに背景色を入れると、うまいこと背景が入ってくる。
                        PrimaryColor.backgroundGreen
                        ForEach(messagesManager.messages, id: \.id) { message in
                            let _ = print("hirohiro_message: ", message, userDefault.workerId ?? "userDefaultのworkerIdが取得できません")
                            let workerId = userDefault.workerId ?? ""
                            let isMessageReceived = message.personalId == workerId
                            MessageBubble(message: message, isMessageReceived: isMessageReceived)
                        }
                    }
                    .padding(.top, 10)
                    .background(.green)
                    .onChange(of: messagesManager.lastMessageId) { id in
                        // When the lastMessageId changes, scroll to the bottom of the conversation
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
                .padding(.vertical, 10)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                // TODO: ここでスタッフモードは、5W1Hの入力はしないようにする。オーナーと同じようにしておく。
                NavigationLink(
                    destination: WorkerChatInputFiveWsAndOneHView(),
                    isActive: $isWorkerChatTopViewActive) {
                        Button(
                            action: {
                                self.isWorkerChatTopViewActive = true
                            },
                            label: {
                                Text("送信する")
                                    .foregroundColor(Color.black)
                                    .frame(width: 200, height: 50)
                                    .background(PrimaryColor.buttonColor)
                                    .cornerRadius(20)
                                    .padding()
                            }
                        )
                    }
                Spacer()
            }
        }
        .background(PrimaryColor.background)
        .onAppear {
            messagesManager.getMessages(personalId: "")
        }
    }
}

struct ChatTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerChatTopView(
//            store: Store(
//                initialState: WorkerChatTopState(),
//                reducer: workerChatTopReducer,
//                environment: WorkerChatTopEnvironMent()
//            )
        )
    }
}

struct MessageBubble: View {
    var message: Message
    var isMessageReceived: Bool

    var body: some View {
        if isMessageReceived {
            // 右側 自分自身
            VStack {
                HStack(spacing: .zero) {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("\(message.personalInformation)")
                            .font(.caption2)
                            .fontWeight(.thin)
                            .foregroundColor(.gray)
                            .padding(isMessageReceived ? .leading : .trailing, 10)
                        Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .padding(isMessageReceived ? .leading : .trailing, 10)
                        Spacer()
                    }
                    Spacer().frame(width: 5)
                    Text(message.text)
                        .font(.caption2)
                        .fontWeight(.thin)
                        .padding(.all, 10)
                        .foregroundColor(.black)
                        .background(isMessageReceived ? PrimaryColor.buttonLightGray : PrimaryColor.buttonRed)
                        .cornerRadius(10)
                    Spacer().frame(width: 5)
                }
                .frame(maxWidth: 300, alignment: isMessageReceived ? .leading : .trailing)
            }
        } else {
            // 左側　自分以外
            VStack {
                HStack(spacing: .zero) {
                    Text(message.text)
                        .font(.caption2)
                        .fontWeight(.thin)
                        .padding(.all, 10)
                        .foregroundColor(.black)
                        .background(isMessageReceived ? PrimaryColor.buttonLightGray : PrimaryColor.buttonRed)
                        .cornerRadius(10)
                    Spacer().frame(width: 5)
                    VStack {
                        Spacer()
                        Text("\(message.personalInformation)")
                            .font(.caption2)
                            .fontWeight(.thin)
                            .foregroundColor(.gray)
                            .padding(isMessageReceived ? .leading : .trailing, 10)
                        Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .padding(isMessageReceived ? .leading : .trailing, 10)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(maxWidth: 300, alignment: isMessageReceived ? .leading : .trailing)
            }
            .padding(.horizontal, 10)
        }
        Spacer().frame(height: 10)
    }
}
