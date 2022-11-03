//
//  WorkerPulseTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/30.
//

import SwiftUI

struct WorkerPulseTopView: View {
    var action: () -> Void

    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Text("xxさん")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 92)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                    .padding(.horizontal, 22)
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
                    action()
                }, label: {
                    Text("パルス測定")
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

struct WorkerPulseTopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerPulseTopView(action: {})
    }
}
