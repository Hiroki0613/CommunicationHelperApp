//
//  WorkerChatTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import ComposableArchitecture
import SwiftUI

struct WorkerChatTopView: View {
    let store: Store<WorkerChatTopState, WorkerChatTopAction>
    @State private var isWorkerChatTopViewActive: Bool = false
    @StateObject var messagesManager = MessagesManager()

    var body: some View {
        VStack {
            VStack {
                ChatTitleRow()
//                ScrollView {
////                    ForEach(messageArray, id: \.self) { text in
////                        ChatMessageBubble(
////                            message: ChatMessage(
////                                id: "12345",
////                                text: text,
////                                received: text.count % 2 == 1 ? true : false,
////                                timestamp: Date()
////                            )
////                        )
////                    }
//
//                }
                ScrollViewReader { proxy in
                    ScrollView {
                        // TODO: ここに背景色を入れると、うまいこと背景が入ってくる。
                        PrimaryColor.backgroundGreen
                        ForEach(messagesManager.messages, id: \.id) { message in
                            let _ = print("hirohiro_message: ", message)
                            MessageBubble(message: message)
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
                NavigationLink(
                    destination: WorkerChatInputFiveWsAndOneHView(
                        store: store,
                        isWorkerChatTopViewActive: $isWorkerChatTopViewActive
                    ),
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
//            ChatMessageField()
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
            store: Store(
                initialState: WorkerChatTopState(),
                reducer: workerChatTopReducer,
                environment: WorkerChatTopEnvironMent()
            )
        )
    }
}

struct MessageBubble: View {
    var message: Message
    // TODO: MessageBubbleでのアライメント、色などはpersonalIdで判別すること。
    var isMessageReceived = true

    // TODO: 身体情報を入れるUIを作成すること personalInformation
    var body: some View {
        VStack(alignment: isMessageReceived ? .leading : .trailing) {
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
        .frame(maxWidth: .infinity, alignment: isMessageReceived ? .leading : .trailing)
        .padding(isMessageReceived ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}
