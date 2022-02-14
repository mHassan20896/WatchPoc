//
//  ContentView.swift
//  WatchPoc WatchKit Extension
//
//  Created by VenD-Hassan on 2/4/22.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @ObservedObject var notification = NotificationManager()
    
    var body: some View {
        if notification.displayMessage == "agree" {
           return AnyView(SuccessView())
        } else if notification.displayMessage == "disagree" {
           return AnyView(FailureView())
        } else {
            return AnyView(Text("BaadMay")
                            .font(.title))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
        FailureView()
    }
}

struct SuccessView: View {
    var body: some View {
        VStack {
            Text("BaadMay")
                .font(.title)
            Image(systemName: "checkmark.circle")
                .foregroundColor(Color.green)
                .font(.system(size: 60))
            Text("Payment successfull")
        }
    }
}

struct FailureView: View {
    var body: some View {
        VStack {
            Text("BaadMay")
                .font(.title)
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(Color.red)
                .font(.system(size: 60))
            Text("Payment Declined")
        }
    }
}

final class NotificationManager: NSObject, ObservableObject {
    
    @Published var displayMessage: String = "Hello World!"
    
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
        DispatchQueue.main.async(execute: {
            print("action: \(response.actionIdentifier)")
            self.displayMessage = response.actionIdentifier
        })
    }
    
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent: UNNotification, withCompletionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent fired from watch delegate")
        withCompletionHandler(
            UNNotificationPresentationOptions.sound)
    }
}
