//
//  WorkerEndOfWorkTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/30.
//

import SwiftUI

struct WorkerEndOfWorkTopView: View {
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
                    .padding(.horizontal, 19)
                Spacer().frame(height: 33)
                ZStack {
                    Rectangle()
                        .fill(PrimaryColor.buttonColor)
                        .frame(width: 282, height: 232)
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
                Spacer().frame(height: 46)
                NavigationLink(
                    destination: {
                        WorkerEndOfWorkQRCodeView()
                    },
                    label: {
                        Text("報告")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 96)
                            .background(PrimaryColor.buttonRedColor)
                            .padding(.horizontal, 84)
                    }
                )
            }
        }
    }
}

struct WorkerEndOfWorkTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerEndOfWorkTopView()
    }
}
