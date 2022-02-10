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
            return AnyView(Text("Hello world!"))
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
            Text("Baadmay")
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
            Text("Baadmay")
                .font(.title)
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(Color.red)
                .font(.system(size: 60))
            Text("Payment failed")
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
        print("action: \(response.actionIdentifier)")
        displayMessage = response.actionIdentifier
    }
}
