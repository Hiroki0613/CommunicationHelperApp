////
////  ChatTitleRow.swift
////  CommunicationHelperApp
////
////  Created by 近藤宏輝 on 2022/11/03.
////
//
//import SwiftUI
//
//struct ChatTitleRow: View {
//    var imageUrl = URL(string: "https://picsum.photos/50")
//    var name = "スタッフさん"
//
//    var body: some View {
//        HStack(spacing: 20) {
//            AsyncImage(url: imageUrl) { image in
//                image.resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 50, height: 50)
//                    .cornerRadius(50)
//            } placeholder: {
//                ProgressView()
//            }
//            VStack(alignment: .leading) {
//                Text(name)
//                    .font(.title).bold()
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//        }
//        .padding()
//    }
//}
//
//struct TitleRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatTitleRow()
//            .background(PrimaryColor.background)
//    }
//}
