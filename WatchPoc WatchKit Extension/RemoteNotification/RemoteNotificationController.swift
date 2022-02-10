//
//  RemoteNotificationController.swift
//  WatchPoc WatchKit Extension
//
//  Created by VenD-Hassan on 2/4/22.
//

import WatchKit
import SwiftUI
import UserNotifications
import Firebase

final class RemoteNotificationController: WKUserNotificationHostingController<RemoteNotificationView>{
    static let categoryIdentifier = "watchPoc"
    
    private var model: RemoteNotificationModel!
//    private var notification = NotificationService()
    
    override var body: RemoteNotificationView {
        return RemoteNotificationView(model: model)
    }
    
    override func didReceive(_ notification: UNNotification) {
        
        print("remote notification: \(notification)")
        
        let content = notification.request.content
        let title = content.title
        let body = content.body
        
        let doneAction = UNNotificationAction(identifier: "agree", title: "Agree", options: .foreground)
        let laterAction = UNNotificationAction(identifier: "disagree", title: "Disgree", options: .foreground)
        
        let current = UNUserNotificationCenter.current()
        let category = UNNotificationCategory(
            identifier: Self.categoryIdentifier,
          actions: [doneAction, laterAction],
          intentIdentifiers: [])
        
        current.setNotificationCategories([category])
        
        
        model = RemoteNotificationModel(title: title, details: body)
    }
}

extension RemoteNotificationController: UNUserNotificationCenterDelegate {
    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
        print("did receive \(notification)")
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print(response)
    }
}

class NotificationService: UNNotificationServiceExtension {
  var contentHandler: ((UNNotificationContent) -> Void)?
  var bestAttemptContent: UNMutableNotificationContent?

  override func didReceive(_ request: UNNotificationRequest,
                           withContentHandler contentHandler: @escaping (UNNotificationContent)
                             -> Void) {
    print(request)
  }

  override func serviceExtensionTimeWillExpire() {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
      contentHandler(bestAttemptContent)
    }
  }
}
