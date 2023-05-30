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
    var ownerId: String? { get set }
    var deviceId: String? { get set }
    var fcmToken: String? { get set }
    var workerId: String? { get set }
    var isBlackAndWhiteMode: Bool? { get set }
    var loginDate: Date? { get set }
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
    var ownerId: String? {
        get {
            return UserDefaults.standard.object(forKey: "officeId") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "officeId")
            UserDefaults.standard.synchronize()
        }
    }
    var deviceId: String? {
        get {
            return UserDefaults.standard.object(forKey: "deviceId") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "deviceId")
            UserDefaults.standard.synchronize()
        }
    }
    var fcmToken: String? {
        get {
            return UserDefaults.standard.object(forKey: "fcmToken") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fcmToken")
            UserDefaults.standard.synchronize()
        }
    }
    var workerId: String? {
        get {
            return UserDefaults.standard.object(forKey: "workerId") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "workerId")
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
    var loginDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: "loginDate") as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "loginDate")
            UserDefaults.standard.synchronize()
        }
    }
}
