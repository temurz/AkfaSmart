//
//  NotificationManager.swift
//  AkfaSmart
//

import UIKit
import FirebaseMessaging
import UserNotifications
import FirebaseCore

final class NotificationManager: NSObject {
    static let shared = NotificationManager()
    private override init() {}

    func setup(application: UIApplication) {
        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

extension NotificationManager: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        AuthApp.shared.fcmToken = fcmToken
        print("✅ FCM Token received: \(fcmToken ?? "nil")")
    }
}
