//
//  OwnerManageStaffView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/16.
//

import SwiftUI

struct OwnerManageStaffView: View {

    init() {
        UITableView.appearance().backgroundColor = PrimaryUIColor.background
     }

    var body: some View {
        List {
            Section("スタッフ") {
                Text("山田さん")
                Text("鈴木さん")
                Text("佐藤さん")
                Text("遠藤さん")
            }
        }
    }
}

struct OwnerManageStaffView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManageStaffView()
    }
}
