//
//  Message.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/04/24.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var personalId: String
    // 身体情報
    /*
     支援者の方も脈拍測定は必要です。
     理由:障害当事者が支援者側の生態情報を見て相手の感情を読み取るため。
     */
    var personalInformation: String
    var text: String
    var timestamp: Date
}
