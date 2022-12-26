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
    let store: Store<WorkerChatInputFiveWsAndOneHState, WorkerChatInputFiveWsAndOneHAction>
    @State private var whereText = ""
    @State private var whoText = ""
    @State private var whatText = ""
    @State private var whenText = ""
    @State private var whyText = ""
    @State private var howText = ""
    @FocusState private var focusedField: Field?

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                PrimaryColor.buttonColor
                VStack(spacing: 10) {
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　どこで",
                        inputText: whereText,
                        inputTextBinding: $whereText,
                        suffixText: "で",
                        textOpacity: true,
                        onSubmitAction: {
                            print("hirohiro_どこで入力: ", whereText)
                            focusedField = .whoText
                            // TODO: TCAを使うと、なぜか前の画面に戻ってしまう・・・
                            viewStore.send(.afterInputWhere)
                        }
                    )
                    .focused($focusedField, equals: .whereText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　誰が",
                        inputText: whoText,
                        inputTextBinding: $whoText,
                        suffixText: "が",
//                        textOpacity: viewStore.hasInputWho,
                        textOpacity: true,
                        onSubmitAction: {
                            print("hirohiro_だれが入力: ", whoText)
                            focusedField = .whatText
                            viewStore.send(.afterInputWho)
                        }
                    )
                    .focused($focusedField, equals: .whoText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　何を",
                        inputText: whatText,
                        inputTextBinding: $whatText,
                        suffixText: "を",
                        textOpacity: viewStore.hasInputWhat,
                        onSubmitAction: {
                            print("hirohiro_なにを入力: ", whatText)
                            focusedField = .whenText
                            viewStore.send(.afterInputWhat)
                        }
                    )
                    .focused($focusedField, equals: .whatText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　いつ",
                        inputText: whenText,
                        inputTextBinding: $whenText,
                        suffixText: "に",
                        textOpacity: viewStore.hasInputWhen,
                        onSubmitAction: {
                            print("hirohiro_いつ入力: ", whenText)
                            focusedField = .whyText
                            viewStore.send(.afterInputWhen)
                        }
                    )
                    .focused($focusedField, equals: .whenText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　なぜ",
                        inputText: whyText,
                        inputTextBinding: $whyText,
                        suffixText: "",
                        textOpacity: viewStore.hasInputWhy,
                        onSubmitAction: {
                            print("hirohiro_なぜ入力: ", whyText)
                            focusedField = .howText
                            viewStore.send(.afterInputWhy)
                        }
                    )
                    .focused($focusedField, equals: .whyText)
                    makeFiveWsAndOneHTextField(
                        placeHolder: "　どうした",
                        inputText: howText,
                        inputTextBinding: $howText,
                        suffixText: "",
                        textOpacity: viewStore.hasInputHow,
                        onSubmitAction: {
                            print("hirohiro_どうした入力: ", howText)
                            let allString = whereText + whoText + whatText + whenText + whyText + howText
                            viewStore.send(.getAllString(whereText: whereText, whoText: whoText, whatText: whatText, whenText: whenText, whyText: whyText, howText: howText))
                            viewStore.send(.afterInputHow)
                        }
                    )
                    .focused($focusedField, equals: .howText)
                }
                .padding()
            }
            .onTapGesture {
                focusedField = nil
                viewStore.send(.getAllString(whereText: whereText, whoText: whoText, whatText: whatText, whenText: whenText, whyText: whyText, howText: howText))
            }
        }
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
        textOpacity: Bool,
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
//        .opacity(textOpacity ? 1.0 : 0.0)
    }
}

struct WorkerChatInputSentenceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerChatInputSentenceView(
            store: Store(
                initialState: WorkerChatInputFiveWsAndOneHState(),
                reducer: workerChatInputFiveWsAndOneHReducer,
                environment: WorkerChatInputFiveWsAndOneHEnvironment()
            )
        )
    }
}
