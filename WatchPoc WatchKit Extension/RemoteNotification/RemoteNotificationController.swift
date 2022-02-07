//
//  RemoteNotificationController.swift
//  WatchPoc WatchKit Extension
//
//  Created by VenD-Hassan on 2/4/22.
//

import WatchKit
import SwiftUI
import UserNotifications

final class RemoteNotificationController: WKUserNotificationHostingController<RemoteNotificationView>{
    static let categoryIdentifier = "watchPoc"
    
    private var model: RemoteNotificationModel!
    
    override var body: RemoteNotificationView {
        return RemoteNotificationView(model: model)
    }
    
    override func didReceive(_ notification: UNNotification) {
        
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
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print(response)
    }
}