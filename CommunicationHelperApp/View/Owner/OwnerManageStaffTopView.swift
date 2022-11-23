//
//  OwnerManageStaffTopView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/16.
//

import SwiftUI

struct OwnerManageStaffTopView: View {
    var nameArray = ["山田", "鈴木", "佐藤", "遠藤"]

    init() {
        UITableView.appearance().backgroundColor = PrimaryUIColor.background
     }

    var body: some View {
        ZStack {
            PrimaryColor.background
            ScrollView {
                VStack {
                    Spacer().frame(height: 20)
                    Text("スタッフ")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    ForEach(0..<nameArray.count) { index in
                        OwnerManageStaffCellView(name: nameArray[index])
                            .cornerRadius(20)
                        Spacer().frame(height: 10)
                    }
                }
                .padding(.horizontal, 30)
            }
            .clipped()
        }
    }
}

struct OwnerManageStaffView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManageStaffTopView()
    }
}
