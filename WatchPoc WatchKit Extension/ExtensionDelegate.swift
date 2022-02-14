//
//  ExtensionDelegate.swift
//  WatchPoc WatchKit Extension
//
//  Created by VenD-Hassan on 2/4/22.
//

import WatchKit
import UserNotifications
import FirebaseMessaging
import FirebaseCore

final class ExtensionDelegate: NSObject, WKExtensionDelegate, MessagingDelegate {
    /// MessagingDelegate
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("token:\n" + fcmToken!)
        Messaging.messaging().subscribe(toTopic: "testing") { error in
          print("Subscribed to weather topic")
        }
        //      Messaging.messaging().subscribe(toTopic: "watch") { error in
        //        if error != nil {
        //          print("error:" + error.debugDescription)
        //        } else {
        //          print("Successfully subscribed to topic")
        //        }
        //      }
    }
    
    func didRegisterForRemoteNotifications(withDeviceToken deviceToken: Data) {
        print("Set APNS Token\n")
        Messaging.messaging().apnsToken = deviceToken
    }
    //    func didRegisterForRemoteNotifications(withDeviceToken deviceToken: Data) {
    //        print(deviceToken.reduce("") { $0 + String(format: "%02x", $1) })
    //    }
    
    func applicationDidFinishLaunching() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                WKExtension.shared().registerForRemoteNotifications()
            }
        }
        Messaging.messaging().delegate = self
        FirebaseApp.configure()
        //        async {
        //            do {
        //                try await UNUserNotificationCenter
        //                    .current()
        //                    .requestAuthorization(options: [.badge, .sound, .alert]) { a, b -> Void in
        //                        print("testing?")
        //                    }
        //                // guard success else { return }
        //                // 4
        //                await MainActor.run {
        //                    WKExtension.shared().registerForRemoteNotifications()
        //                }
        //            } catch {
        //                print(error.localizedDescription)
        //            }
        //        }
        
    }
    
    func applicationDidBecomeActive() {
        print("applicationDidBecomeActive")
    }
    
    func applicationDidEnterBackground() {
        print("applicationDidEnterBackground")
    }
}

//extension ExtensionDelegate: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
//        print(response)
//    }
//}
