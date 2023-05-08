//
//  ChatMessageField.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import SwiftUI

struct ChatMessageField: View {
    @EnvironmentObject var messagesManager: MessagesManager
    @State private var message = ""
    @State private var pulseRate: Float = 0
    @State private var openView: Bool = false

    var body: some View {
        HStack {
            CustomTextField(
                placeholder: Text("文章を入力してください"),
                text: $message
            )
            .foregroundColor(.black)
            .font(.caption)
            .frame(height: 18)
            .disableAutocorrection(true)
            Button {
                if message.isEmpty { return }
                openView.toggle()
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding(10)
                    .background(.cyan)
                    .cornerRadius(20)
            }
        }
        .fullScreenCover(
            isPresented: $openView,
            content: {
                PulseView(messageText: message)
                    .onDisappear { message = "" }
            }
        )
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.mint)
        .cornerRadius(50)
        .padding()
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> Void = { _ in }
    var commit: () -> Void = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

struct ChatMessageField_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageField()
    }
}
