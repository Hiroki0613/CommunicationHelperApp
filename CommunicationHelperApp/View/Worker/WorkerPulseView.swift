//
//  WorkerPulseView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//

// https://github.com/athanasiospap/Pulse
import SwiftUI

struct WorkerPulseView: View {
    var body: some View {
        // TODO: 近藤　チャット機能＋パルス機能にする。
        /*
         ・心拍数だけを送るものは必要なし
         ・その人の特性については、外す(偏見を持つ可能性あり)
         　
         ターゲット
         　知的に問題ないけれど、気持ちが読めない、相手の発言意図を理解できない。相手の表情を読めない。自分の考えをまとめて話をするのが難しい。
         　
         ここを対象にしたアプリ。
         ・チャットを使ったものをメイン
         　→論点がずれるを防止
         　→言った、言わない問題を防止
         　→どうしても、解釈がずれるので、すりあわせ、すりあわせ
         　→生体情報を載せて、非言語コミュニケーションをオンラインで取れるようにする。
         ( 表情、ジェスチャー、心拍数といった言葉以外で人間が発している情報をデータにする。そういう発想から心拍数が思い付いた )
         */
        
        
        /*
         意見が対立した時
         自分が打つ
         相手が打つ
         　
         どこかのタイミングで、それぞれが送信する。
         二人とも送信したことがわかった瞬間に、同時に表示
         　
         お互いの認識さを比較する。
         そして、すりあわせ、すりあわせ
         
         
         そうすることで、一通りの意見をそれぞれ言える。
         　
         防げること
         　
         人間なので、声同士で話すと
         「それは違う！」って、話を割り込んで反論されて、
         その待っている間に、自分の言いたい意見が忘れる。
         　
         あるいは、押し問答に発展して喧嘩に発展してしまう。
         
         
         
         
         helpまでの仮定
         1. それぞれが送信されて、同時に表示されます
         2. その上で、すり合わせをするために、同時表示のコミュニケーションを繰り返す。
         3. しかし、同時に表示するということは、自分が送信したら待たないといけない。
         4. その時に、自分の意見を早く通すためにhelpを押すと、同時に表示される前にhelpを押した側の文章が表れる
         
         */
        PulseView()
    }
}

struct WorkerPulseView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerPulseView()
    }
}
