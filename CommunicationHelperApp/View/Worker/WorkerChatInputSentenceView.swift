//
//  WorkerChatInputSentenceView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/13.
//

import SwiftUI

struct WorkerChatInputSentenceView: View {
    @State var whereText = ""
    @State var whoText = ""
    @State var whatText = ""
    @State var whenText = ""
    @State var whyText = ""
    @State var howText = ""

    var body: some View {
        ZStack {
            PrimaryColor.buttonColor
            VStack(spacing: 10) {
                makeFiveWsAndOneHTextField(
                    placeHolder: "　どこで",
                    inputText: whereText,
                    inputTextBinding: $whereText,
                    suffixText: "で"
                )
                makeFiveWsAndOneHTextField(
                    placeHolder: "　誰が",
                    inputText: whoText,
                    inputTextBinding: $whoText,
                    suffixText: "が"
                )
                makeFiveWsAndOneHTextField(
                    placeHolder: "　何を",
                    inputText: whatText,
                    inputTextBinding: $whatText,
                    suffixText: "を"
                )
                makeFiveWsAndOneHTextField(
                    placeHolder: "　いつ",
                    inputText: whenText,
                    inputTextBinding: $whenText,
                    suffixText: "に")
                makeFiveWsAndOneHTextField(
                    placeHolder: "　なぜ",
                    inputText: whyText,
                    inputTextBinding: $whyText,
                    suffixText: ""
                )
                makeFiveWsAndOneHTextField(
                    placeHolder: "　どうした",
                    inputText: howText,
                    inputTextBinding: $howText,
                    suffixText: ""
                )
            }
            .padding()
        }
    }

    func makeFiveWsAndOneHTextField(
        placeHolder: String,
        inputText: String,
        inputTextBinding: Binding<String>,
        suffixText: String
    ) -> some View {
        HStack {
            TextField("", text: inputTextBinding)
                .font(.system(size: 16))
                .foregroundColor(Color.black)
                .placeholder(when: inputText.isEmpty) {
                    Text(placeHolder).foregroundColor(.gray)
                }
                .multilineTextAlignment(.leading)
                .frame(width: inputText.isEmpty ? 140 : inputText.size(with: UIFont.systemFont(ofSize: 16)).width + 10, height: 36.0)
                .background(PrimaryColor.buttonRedColor.opacity(0.3))
                .cornerRadius(20)
            Text(suffixText)
                .foregroundColor(Color.black)
            Spacer()
        }
    }
}

struct WorkerChatInputSentenceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerChatInputSentenceView()
    }
}
