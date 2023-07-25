//
//  WorkerEndOfWorkTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/30.
//

import SwiftUI

struct WorkerEndOfWorkTopView: View {
    var action: () -> Void

    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Text("ニックネーム")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 92)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                    .padding(.horizontal, 19)
                Spacer().frame(height: 33)
                Text("70")
                    .fontWeight(.semibold)
                    .font(.system(size: 128))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 276)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                    .padding(.horizontal, 22)
                Spacer().frame(height: 46)
                Button(action: {
                    // TODO: 報告が完了したことを何かしらダイアログで伝えたい。Push通知でも可。とりあえず、通知できた方が良い。双方にわかるようにする。
                    action()
                }, label: {
                    Text("報告")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 91)
                        .background(PrimaryColor.buttonRedColor)
                        .cornerRadius(20)
                        .padding(.horizontal, 22)
                })
            }
        }
    }
}

struct WorkerEndOfWorkTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerEndOfWorkTopView(action: {})
    }
}
