//
//  WorkerQRCodeView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/30.
//

import SwiftUI

// QRコードを作成
struct WorkerQRCodeView: View {
    @State private var qrCodeImage: UIImage?
    private let qRCodeGenerator = QRCodeGenerator()

    var body: some View {
        ZStack {
            PrimaryColor.background
            if let qrCodeImage = qRCodeGenerator.generate(
                with: "https://dev.classmethod.jp/articles/swift-generate-qr-code/"
            ) {
                VStack {
                    Text("おはようございます。\nニックネームさん")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    Image(uiImage: qrCodeImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct WorkerQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        WorkerQRCodeView()
    }
}
