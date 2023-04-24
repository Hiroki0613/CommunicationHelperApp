//
//  WorkerChatInputFiveWsAndOneHView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/05.
//

import ComposableArchitecture
import SwiftUI

struct WorkerChatInputFiveWsAndOneHView: View {
    let store: Store<WorkerChatTopState, WorkerChatTopAction>
    @Binding var isWorkerChatTopViewActive: Bool

    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Spacer().frame(height: 20)
                HStack {
                    // 5W1Hを一つ一つ入力するスタイルに変更する。
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
//                ZStack {
                    // TCAのスコープを通して、WorkerChatInputSentenceViewとも連動させる。
                    WorkerChatInputSentenceView(
                        store: store.scope(
                            state: \.workerChatInputFiveWsAndOneHState,
                            action: WorkerChatTopAction.workerChatInputFiveWsAndOneHAction
                        )
                    )
//                    .frame(height: 312)
//                    .cornerRadius(20)
//                    .padding(.horizontal, 22)
//                }
//                Spacer().frame(height: 10)
//                NavigationLink(
//                    destination: {
//                        // TODO: ここにパルス情報を送信すること。
//                        WorkerPulseView(messageText: messageText)
//                    },
//                    label: {
//                        Text("送信")
//                            .foregroundColor(Color.white)
//                            .frame(width: 270, height: 70)
//                            .background(PrimaryColor.buttonRedColor)
//                            .cornerRadius(20)
//                    }
//                )
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

//struct WorkerFiveWsAndOneHChatInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkerChatInputFiveWsAndOneHView(
//            store: Store(
//                initialState: WorkerChatTopState(),
//                reducer: workerChatTopReducer,
//                environment: WorkerChatTopEnvironMent()
//            )
//        )
//    }
//}

extension String {
    func size(with font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font : font]
        return (self as NSString).size(withAttributes: attributes)
    }
}
