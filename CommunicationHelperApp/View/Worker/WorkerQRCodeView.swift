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
    var userDefault: UserDefaultDataStore = UserDefaultsDataStoreProvider.provide()

    var body: some View {
        ZStack {
            PrimaryColor.background
            if let deviceId = userDefault.deviceId,
               let qrCodeImage = qRCodeGenerator.generate(with: deviceId) {
                VStack {
                    Text("おはようございます。\n")
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
