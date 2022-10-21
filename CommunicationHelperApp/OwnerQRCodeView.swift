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
            if let qrCodeImage = qRCodeGenerator.generate(with: "https://dev.classmethod.jp/articles/swift-generate-qr-code/") {
                Image(uiImage: qrCodeImage)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        }
    }
}
