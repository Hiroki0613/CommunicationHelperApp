////
////  OwnerManageWorkerTopView.swift
////  CommunicationHelperApp
////
////  Created by 近藤宏輝 on 2022/11/16.
////
//
//import ComposableArchitecture
//import SwiftUI
//
//struct OwnerManageWorkerTopView: View {
//    let viewStore: ViewStore<OwnerTopState, OwnerTopAction>
//    var nameArray = ["ヤマダ", "スズキ", "サトウ", "エンドウ"]
//    var averagePulseArray = [60, 70, 80, 70]
//    // TODO: ここの個人の特性は、偏見を持つ可能性があるために省くこと。
//    var characteristicArray = [
//        "少し落ち着きが無いところがある",
//        "いつもご機嫌である",
//        "耳が聞こえづらいので近くで声をかけてあげて",
//        "釣りの趣味があって、話を振ってあげると喜ぶ"
//    ]
//
//    var body: some View {
//        ZStack {
//            PrimaryColor.background
//            ScrollView {
//                VStack {
//                    Spacer().frame(height: 20)
//                    Text("作業者")
//                        .fontWeight(.semibold)
//                        .font(.system(size: 20))
//                        .foregroundColor(Color.black)
//                    ForEach(0..<nameArray.count) { index in
//                        OwnerManageWorkerCellView(
//                            name: nameArray[index],
//                            averagePulse: averagePulseArray[index],
//                            characteristic: characteristicArray[index]
//                        )
//                        .cornerRadius(20)
//                        Spacer().frame(height: 10)
//                    }
//                }
//                .padding(.horizontal, 30)
//            }
//            .clipped()
//        }
//    }
//}
//
//struct OwnerManageWorkerView_Previews: PreviewProvider {
//    static var previews: some View {
//        OwnerManageStaffTopView()
//    }
//}
