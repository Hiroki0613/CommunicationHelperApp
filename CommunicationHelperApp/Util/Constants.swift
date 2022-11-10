//
//  Constants.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/21.
//

import SwiftUI

enum PrimaryColor {
    static let buttonColor = Color(red: 0.961, green: 0.961, blue: 0.937)
    static let buttonRedColor = Color(red: 0.758, green: 0.145, blue: 0.145)
    static let background = Color(red: 0.424, green: 0.780, blue: 0.761)
}

enum PrimaryUIColor {
    static let background = UIColor.init(red: 0.424, green: 0.780, blue: 0.761, alpha: 1)
}

enum UserDefaultsString {
    // officeIdから全てfirebaseで取得していく。
    static let hasLogin = "hasLogin"
    static let officeId = "officeId"
    static let terminalId = "terminalId"
}
