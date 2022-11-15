//
//  ChatMessageBubble.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import SwiftUI

struct ChatMessageBubble: View {
    // TODO: FireStoreからチャットの情報を受け取る。ただし通信回数には注意するように
    var message: ChatMessage
    @State private var showTime = false

    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
                   HStack {
                       Text(message.text)
                           .padding()
                           .background(
                            message.received
                            ? Color.brown
                            : Color.cyan
                           )
                           .cornerRadius(30)
                   }
                   .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
                   .onTapGesture {
                       showTime.toggle()
                   }
                   if showTime {
                       Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                           .font(.caption2)
                           .foregroundColor(.gray)
                           .padding(message.received ? .leading : .trailing, 25)
                   }
               }
               .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
               .padding(message.received ? .leading : .trailing)
               .padding(.horizontal, 10)
    }
}

struct ChatMessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageBubble(
            message: ChatMessage(
            id: "",
            text: "",
            received: true,
            timestamp: Date()
            )
        )
    }
}
