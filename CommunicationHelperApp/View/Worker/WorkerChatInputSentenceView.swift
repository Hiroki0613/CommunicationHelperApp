//
//  WorkerChatInputSentenceView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/13.
//

import ComposableArchitecture
import SwiftUI

enum Field: Hashable {
    case whereText
    case whoText
    case whatText
    case whenText
    case whyText
    case howText
}

struct WorkerChatInputSentenceView: View {
    @State private var isWorkerChatInputSentenceViewActive = false
    @State private var whereText = ""
    @State private var whoText = ""
    @State private var whatText = ""
    @State private var whenText = ""
    @State private var whyText = ""
    @State private var howText = ""
    @State private var messageText = ""
    @FocusState private var focusedField: Field?
    @State private var openChatView: Bool = false

    var body: some View {
        VStack {
            ZStack {
                PrimaryColor.buttonColor
                VStack(spacing: 10) {
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　どこで",
                        inputText: whereText,
                        inputTextBinding: $whereText,
                        suffixText: "で",
                        onSubmitAction: {
                            focusedField = .whoText
                            if whereText.isEmpty {
                                messageText = whoText + "が" + whatText + "を" + whenText + "に" + whyText + howText
                            } else {
                                messageText = whereText + "で" + whoText + "が" + whatText + "を" + whenText + "に" + whyText + howText
                            }
                            print("hirohiro_どこで入力: ", whereText, messageText)
                        }
                    )
                    .focused($focusedField, equals: .whereText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　誰が",
                        inputText: whoText,
                        inputTextBinding: $whoText,
                        suffixText: "が",
                        onSubmitAction: {
                            focusedField = .whatText
                            if whoText.isEmpty {
                                messageText = whereText + "で"  + whatText + "を" + whenText + "に" + whyText + howText
                            } else {
                                messageText = whereText + "で"  + whoText + "が" + whatText + "を" + whenText + "に" + whyText + howText
                            }
                            print("hirohiro_だれが入力: ", whoText, messageText)
                        }
                    )
                    .focused($focusedField, equals: .whoText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　何を",
                        inputText: whatText,
                        inputTextBinding: $whatText,
                        suffixText: "を",
                        onSubmitAction: {
                            focusedField = .whenText
                            if whenText.isEmpty {
                                messageText = whereText + "で"  + whoText + "が" + whenText + "に" + whyText + howText
                            } else {
                                messageText = whereText + "で"  + whoText + "が" + whatText + "を" + whenText + "に" + whyText + howText
                            }
                            print("hirohiro_なにを入力: ", whatText, messageText)
                        }
                    )
                    .focused($focusedField, equals: .whatText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　いつ",
                        inputText: whenText,
                        inputTextBinding: $whenText,
                        suffixText: "に",
                        onSubmitAction: {
                            focusedField = .whyText
                            if whenText.isEmpty {
                                messageText = whereText + "で"  + whoText + "が" + whatText + "を" + whyText + howText
                            } else {
                                messageText = whereText + "で"  + whoText + "が" + whatText + "を" + whenText + "に" + whyText + howText
                            }
                            print("hirohiro_いつ入力: ", whenText, messageText)
                        }
                    )
                    .focused($focusedField, equals: .whenText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　なぜ",
                        inputText: whyText,
                        inputTextBinding: $whyText,
                        suffixText: "",
                        onSubmitAction: {
                            focusedField = .howText
                            if whyText.isEmpty {
                                messageText = whereText + "で"  + whoText + "が" + whatText + "を" + whenText + "に" + howText
                            } else {
                                messageText = whereText + "で"  + whoText + "が" + whatText + "を" + whenText + "に" + whyText + howText
                            }
                            print("hirohiro_なぜ入力: ", whyText, messageText)
                        }
                    )
                    .focused($focusedField, equals: .whyText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　どうした",
                        inputText: howText,
                        inputTextBinding: $howText,
                        suffixText: "",
                        onSubmitAction: {
                            print("hirohiro_どうした入力: ", howText)
                            if howText.isEmpty {
                                messageText = whereText + "で"  + whoText + "が" + whatText + "を" + whenText + "に" + whyText
                            } else {
                                messageText = whereText + "で"  + whoText + "が" + whatText + "を" + whenText + "に" + whyText + howText
                            }
                            print("hirohiro_allStringです: ", messageText)
                        }
                    )
                    .focused($focusedField, equals: .howText)
                }
                .padding()
            }
            .frame(height: 312)
            .cornerRadius(20)
            .padding(.horizontal, 22)
            Button(
                action: {
                    if messageText.isEmpty { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        openChatView.toggle()
                    })
                },
                label: {
                    Text("送信")
                        .foregroundColor(Color.white)
                        .frame(width: 270, height: 70)
                        .background(PrimaryColor.buttonRedColor)
                        .cornerRadius(20)
                }
            )
        }
        .onTapGesture {
            focusedField = nil
        }
        .fullScreenCover(
            isPresented: $openChatView,
            content: {
                PulseView(messageText: messageText)
                    .onDisappear {
                        whereText = ""
                        whoText = ""
                        whatText = ""
                        whenText = ""
                        whyText = ""
                        howText = ""
                        messageText = ""
                    }
            }
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focusedField = .whereText
            }
        }
    }

    func makeFiveWsAndOneHTextField(
        placeHolder: String,
        inputText: String,
        inputTextBinding: Binding<String>,
        suffixText: String,
        onSubmitAction: @escaping(() -> Void)
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
                .onSubmit {
                    onSubmitAction()
                }
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
