////
////  OwnerQRCodeView.swift
////  CommunicationHelperApp
////
////  Created by 近藤宏輝 on 2022/10/21.
////
//
//import SwiftUI
//
//// QRコードを作成
//struct OwnerQRCodeView: View {
//    @State private var qrCodeImage: UIImage?
//    @Environment(\.dismiss) private var dismiss
////    var backViewAction: () -> Void
//    private let qRCodeGenerator = QRCodeGenerator()
//
//    var body: some View {
//        ZStack {
//            PrimaryColor.background
//            if let qrCodeOwnerImage = qRCodeGenerator.generate(
//                with: "ownerFirebaseUid"
//            ),
//               let qrCodeWorkerImage = qRCodeGenerator.generate(
//                with: "workerUUID"
//               ) {
//                VStack {
//                    Spacer()
//                    Text("OwnerID")
//                        .fontWeight(.semibold)
//                        .font(.system(size: 20))
//                        .foregroundColor(Color.black)
//                    Image(uiImage: qrCodeOwnerImage)
//                        .resizable()
//                        .frame(width: 200, height: 200)
//                    Spacer().frame(height: 30)
//                    Text("WorkerID")
//                        .fontWeight(.semibold)
//                        .font(.system(size: 20))
//                        .foregroundColor(Color.black)
//                    Image(uiImage: qrCodeWorkerImage)
//                        .resizable()
//                        .frame(width: 200, height: 200)
//                    Spacer().frame(height: 30)
//                    Button(
//                        action: {
//                            dismiss()
//                        }, label: {
//                            Text("戻る")
//                                .foregroundColor(Color.black)
//                                .frame(width: 200, height: 50)
//                                .background(PrimaryColor.buttonColor)
//                                .cornerRadius(20)
//                        }
//                    )
//                    Spacer()
//                }
//            }
//        }
//    }
//}
//
//struct OwnerQRCodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        OwnerQRCodeView()
//    }
//}
