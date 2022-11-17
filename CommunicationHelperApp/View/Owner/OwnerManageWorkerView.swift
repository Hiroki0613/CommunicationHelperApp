//
//  OwnerManageWorkerView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/16.
//

import SwiftUI

struct OwnerManageWorkerView: View {
    var body: some View {
        ZStack {
            PrimaryColor.background
            ZStack {
                Rectangle()
                    .fill(PrimaryColor.buttonColor)
                    .frame(width: 303, height: 272)
                    .cornerRadius(20)
                VStack {
                    Spacer().frame(height: 18)
                    HStack {
                        Spacer().frame(width: 34)
                        Text("支援者")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(width: 303, height: 30, alignment: .leading)
                    }
                    HStack {
                        Text("開始　０：００")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(width: 303, height: 30, alignment: .trailing)
                        Spacer().frame(width: 20)
                    }
                    HStack {
                        Text("終了　０：００")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .frame(width: 303, height: 30, alignment: .trailing)
                        Spacer().frame(width: 20)
                    }
                }
            }
        }
    }
}

struct OwnerManageWorkerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManageWorkerView()
    }
}
