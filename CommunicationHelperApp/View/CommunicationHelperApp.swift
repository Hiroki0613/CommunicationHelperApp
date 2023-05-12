//
//  CommunicationHelperApp.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/10.
//

import ComposableArchitecture
import Firebase
import SwiftUI

// MARK: - AppDelegate Main
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        // Push通知許可のポップアップを表示
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
    -> UIBackgroundFetchResult {
        return UIBackgroundFetchResult.newData
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) { }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else { return }
        print("hirohiro_fcmToken: ", fcmToken)
    }
}

// MARK: - AppDelegate Push Notification
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
        return [[.banner, .badge, .sound]]
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async { }
}

@main
struct CommunicationHelperApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            TopView(
                store: Store(
                    initialState: TopState(
                        ownerState: OwnerTopState(),
                        workerTopState: WorkerTopState()
                    ),
                    reducer: topReducer,
                    environment: TopEnvironment()
                )
            )
//            WorkerChatInputFiveWsAndOneHView(
//                store: Store(
//                    initialState: WorkerChatInputFiveWsAndOneHState(),
//                    reducer: workerChatInputFiveWsAndOneHReducer,
//                    environment: WorkerChatInputFiveWsAndOneHEnvironment()
//                )
//            )
//            AuthTestView()
        }
    }
}
