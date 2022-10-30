//
//  WorkerEndOfWorkQRCodeView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/30.
//

import SwiftUI

struct WorkerEndOfWorkQRCodeView: View {
    @State private var qrCodeImage: UIImage?
    private let qRCodeGenerator = QRCodeGenerator()

    var body: some View {
        ZStack {
            PrimaryColor.background
            if let qrCodeImage = qRCodeGenerator.generate(
                with: "https://dev.classmethod.jp/articles/swift-generate-qr-code/"
            ) {
                VStack {
                    Text("お疲れ様でした。\nニックネームさん")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    Image(uiImage: qrCodeImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Spacer().frame(height: 33)
                    NavigationLink(destination: {
                        WorkerEndOfWorkView()
                    }, label: {
                        Text("QRコードが読み込まれた後の画面")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                    })
                }
            }
        }
    }
}

struct WorkerEndOfWorkQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerEndOfWorkQRCodeView()
    }
}
