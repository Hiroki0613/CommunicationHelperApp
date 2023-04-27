////
////  OwnerSettingOperatingTimeView.swift
////  CommunicationHelperApp
////
////  Created by 近藤宏輝 on 2022/11/23.
////
//
//import SwiftUI
//
//struct OwnerSettingOperatingTimeView: View {
//    var startTime: String
//    var endTime: String
//
//    var body: some View {
//        ZStack {
//            PrimaryColor.buttonColor
//            VStack {
//                Text("支援者")
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .font(.system(size: 20))
//                    .foregroundColor(Color.black)
//                Text("開始　" + startTime)
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                    .font(.system(size: 20))
//                    .foregroundColor(Color.black)
//                Text("終了 " + endTime)
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                    .font(.system(size: 20))
//                    .foregroundColor(Color.black)
//            }
//            .padding(20)
//        }
//    }
//}
//
//struct OwnerSettingOperatingTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        OwnerSettingOperatingTimeView(startTime: "", endTime: "")
//    }
//}
