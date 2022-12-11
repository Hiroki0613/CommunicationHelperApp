//
//  WorkerFiveWsAndOneHChatInputView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/05.
//

import SwiftUI

struct WorkerFiveWsAndOneHChatInputView: View {
    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                HStack {
                    makeInputLabel(text: "どこで")
                    makeInputLabel(text: "誰が")
                    makeInputLabel(text: "何を")
                }
                Spacer().frame(height: 20)
                HStack {
                    makeInputLabel(text: "いつ")
                    makeInputLabel(text: "なぜ")
                    makeInputLabel(text: "どうした")
                }
                Spacer().frame(height: 20)
                ZStack {
                    WorkerChatInputSentenceView()
                        .frame(height: 212)
                        .cornerRadius(20)
                        .padding(.horizontal, 22)
                }
                Spacer().frame(height: 20)
                NavigationLink(
                    destination: {
                        WorkerPulseView()
                    },
                    label: {
                        Text("送信")
                            .foregroundColor(Color.white)
                            .frame(width: 270, height: 90)
                            .background(PrimaryColor.buttonRedColor)
                            .cornerRadius(20)
                    }
                )
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
        WorkerFiveWsAndOneHChatInputView()
    }
}


struct WorkerChatInputSentenceView: View {
    var body: some View {
        ZStack {
            PrimaryColor.buttonColor
            // TODO: ここにチャットの文章を5W1Hで掲載する。テキストを薄く赤い丸で囲ったほうが良さそう。また、最初は"どこで"とプレースホルダーを入れたほうが良さそう。下側には参考文章を入れておくと良いかも。
        }
    }
}
