//
//  ChatMessageField.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import SwiftUI

struct ChatMessageField: View {
    @State private var message = ""

    var body: some View {
        HStack {
            CustomTextField(
                placeholder: Text("文章を入力してください"),
                text: $message
            )
            .frame(height: 52)
            .disableAutocorrection(true)
            Button {
//                messagesManager.sendMessage(text: message)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.yellow)
                    .padding(10)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.gray)
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
