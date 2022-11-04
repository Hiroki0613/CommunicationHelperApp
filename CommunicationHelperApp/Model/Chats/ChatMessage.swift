//
//  ChatMessage.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import Foundation

struct ChatMessage: Identifiable, Codable {
    var id: String
     var text: String
     var received: Bool
     var timestamp: Date
}
