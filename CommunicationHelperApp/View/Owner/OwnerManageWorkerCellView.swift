//
//  OwnerManageWorkerCellView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/23.
//

import SwiftUI

struct OwnerManageWorkerCellView: View {
    var name: String
    var averagePulse: Int
    var characteristic: String

    var body: some View {
        ZStack {
            PrimaryColor.buttonColor
            VStack {
                Text(name + "さん")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                Spacer().frame(height: 20)
                Text("平均心拍数: " + String(averagePulse))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                Spacer().frame(height: 20)
                VStack {
                    Text("特徴")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    Text(characteristic)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                }
            }
            .padding(20)
        }
    }
}

struct OwnerManageWorkerCellView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManageWorkerCellView(
            name: "",
            averagePulse: 0,
            characteristic: ""
        )
    }
}
