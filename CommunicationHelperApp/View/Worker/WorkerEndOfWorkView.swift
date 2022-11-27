//
//  WorkerEndOfWorkView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/30.
//

import SwiftUI

struct WorkerEndOfWorkView: View {
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
                ZStack {
                    Rectangle()
                        .fill(PrimaryColor.buttonColor)
                        .frame(width: 282, height: 232)
                        .cornerRadius(20)
                    VStack {
                        Spacer().frame(height: 13)
                        Text("心拍")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                        Spacer().frame(height: 80)
                        Text("70")
                            .fontWeight(.semibold)
                            .font(.system(size: 40))
                            .foregroundColor(Color.black)
                    }
                }
                Spacer().frame(height: 24)
                ZStack {
                    Rectangle()
                        .fill(PrimaryColor.buttonColor)
                        .frame(width: 282, height: 143)
                    VStack {
                        Spacer().frame(height: 9)
                        Text("今日の振り返り")
                            .fontWeight(.semibold)
                            .font(.system(size: 24))
                            .foregroundColor(Color.black)
                            .cornerRadius(20)
                        Spacer().frame(height: 100)
                    }
                }
            }
        }
    }
}

struct WorkerEndOfWorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerEndOfWorkView()
    }
}
