//
//  WorkerChatInputFiveWsAndOneHView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/05.
//

import SwiftUI

struct WorkerChatInputFiveWsAndOneHView: View {
    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Spacer().frame(height: 20)
                HStack {
                    makeInputLabel(text: "どこで")
                    makeInputLabel(text: "誰が")
                    makeInputLabel(text: "何を")
                }
                Spacer().frame(height: 10)
                HStack {
                    makeInputLabel(text: "いつ")
                    makeInputLabel(text: "なぜ")
                    makeInputLabel(text: "どうした")
                }
                Spacer().frame(height: 10)
                ZStack {
                    WorkerChatInputSentenceView()
                        .frame(height: 312)
                        .cornerRadius(20)
                        .padding(.horizontal, 22)
                }
                Spacer().frame(height: 10)
                NavigationLink(
                    destination: {
                        WorkerPulseView()
                    },
                    label: {
                        Text("送信")
                            .foregroundColor(Color.white)
                            .frame(width: 270, height: 70)
                            .background(PrimaryColor.buttonRedColor)
                            .cornerRadius(20)
                    }
                )
                Spacer()
            }
        }
    }

    func makeInputLabel(text: String) -> some View {
        return Text(text)
            .font(.system(size: 18))
            .foregroundColor(Color.white)
            .frame(width: 84, height: 84)
            .background(PrimaryColor.buttonRedColor)
            .clipShape(Circle())
    }
}

struct WorkerFiveWsAndOneHChatInputView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerChatInputFiveWsAndOneHView()
    }
}


struct WorkerChatInputSentenceView: View {
    @State var whereText = ""
    @State var whoText = ""
    @State var whatText = ""
    @State var whenText = ""
    @State var whyText = ""
    @State var howText = ""
    var happty = ""

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

extension String {
    func size(with font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font : font]
        return (self as NSString).size(withAttributes: attributes)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
