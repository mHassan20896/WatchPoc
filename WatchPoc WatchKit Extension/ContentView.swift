//
//  ContentView.swift
//  WatchPoc WatchKit Extension
//
//  Created by VenD-Hassan on 2/4/22.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State var notification = NotificationManager()
    
    var body: some View {
        Text(notification.displayMessage)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success screen")
    }
}

final class NotificationManager: NSObject {
    
    public var displayMessage: String = "Hello World!"
    
    override init() {
        super.init()
        
        register()
    }
    
    func register() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if response.actionIdentifier == "agree" {
            displayMessage = "Successfully agreed, Congratulations!"
        } else {
            displayMessage = "We hope to see you soon :)"
        }
    }
}
