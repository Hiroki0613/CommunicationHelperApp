//
//  UserDefault+Ext.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/13.
//

import Foundation

//https://qiita.com/YOSUKE8080/items/2cc1491d379ac1e5f9df
struct UserDefaultsDataStoreProvider {
    private static var shared = UserDefaultsDataStoreImpl()
    static func provide() -> UserDefaultDataStore {
        return UserDefaultsDataStoreProvider.shared
    }
}

protocol UserDefaultDataStore {
    var hasLogin: Bool? { get set }
    var officeId: String? { get set }
    var terminalId: String? { get set }
    var isBlackAndWhiteMode: Bool? { get set }
}

private struct UserDefaultsDataStoreImpl: UserDefaultDataStore {
    var hasLogin: Bool? {
        get {
            return UserDefaults.standard.object(forKey: "hasLogin") as? Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasLogin")
            UserDefaults.standard.synchronize()
        }
    }
    var officeId: String? {
        get {
            return UserDefaults.standard.object(forKey: "officeId") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "officeId")
            UserDefaults.standard.synchronize()
        }
    }
    var terminalId: String? {
        get {
            return UserDefaults.standard.object(forKey: "terminalId") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "terminalId")
            UserDefaults.standard.synchronize()
        }
    }
    var isBlackAndWhiteMode: Bool? {
        get {
            return UserDefaults.standard.object(forKey: "isBlackAndWhiteMode") as? Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isBlackAndWhiteMode")
            UserDefaults.standard.synchronize()
        }
    }
}
