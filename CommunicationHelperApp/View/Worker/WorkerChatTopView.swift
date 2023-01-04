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

    var messageArray = [
         "コミュニケーション",
         "どうやってとるの？",
         "チャットでも取れるよ",
         "それすごいね!",
         "具体的な例があるとわかりやすいよ",
         "例えば",
         "心拍数をもとに測定したりとか"
    ]

    var body: some View {
        VStack {
            VStack {
                ChatTitleRow()
                ScrollView {
                    ForEach(messageArray, id: \.self) { text in
                        ChatMessageBubble(
                            message: ChatMessage(
                                id: "12345",
                                text: text,
                                received: text.count % 2 == 1 ? true : false,
                                timestamp: Date()
                            )
                        )
                    }
                }
                .padding(.vertical, 10)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                NavigationLink(
                    destination: {
                        WorkerChatInputFiveWsAndOneHView(store: store)
                    },
                    label: {
                        Text("送信する")
                            .foregroundColor(Color.black)
                            .frame(width: 200, height: 50)
                            .background(PrimaryColor.buttonColor)
                            .cornerRadius(20)
                            .padding()
                    })
                Spacer()
            }
//            ChatMessageField()
        }
        .background(PrimaryColor.background)
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
