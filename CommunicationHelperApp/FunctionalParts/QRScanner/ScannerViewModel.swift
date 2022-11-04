//
//  ScannerViewModel.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/22.
//

import Foundation

class ScannerViewModel: ObservableObject {
    let scanInterval: Double = 1.0
    @Published var lastQrCode: String = "QRコード"
    @Published var isShowing: Bool = false

    // TODO: ScannerViewModelはTCA化して廃止する
//    func onFoundQrCode(_ code: String) {
//        self.lastQrCode = code
//        isShowing = false
//    }
}
