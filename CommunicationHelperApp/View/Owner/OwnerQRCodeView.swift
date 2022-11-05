//
//  OwnerQRCodeView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/21.
//

import SwiftUI

// QRコードを作成
struct OwnerQRCodeView: View {
    @State private var qrCodeImage: UIImage?
    private let qRCodeGenerator = QRCodeGenerator()

    var body: some View {
        ZStack {
            PrimaryColor.background
            if let qrCodeOwnerImage = qRCodeGenerator.generate(
                with: "ownerFirebaseUid"
            ),
               let qrCodeWorkerImage = qRCodeGenerator.generate(
                with: "workerUUID"
               ) {
                VStack {
                    Text("OwnerID")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    Image(uiImage: qrCodeOwnerImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Spacer().frame(height: 70)
                    Text("WorkerID")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    Image(uiImage: qrCodeWorkerImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct OwnerQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerQRCodeView()
    }
}
