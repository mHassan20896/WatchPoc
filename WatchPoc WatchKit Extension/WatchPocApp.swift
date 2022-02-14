//
//  WatchPocApp.swift
//  WatchPoc WatchKit Extension
//
//  Created by VenD-Hassan on 2/4/22.
//

import SwiftUI
import Firebase

@main
struct WatchPocApp: App {
    
    init() {
        FirebaseApp.configure()
        Messaging.messaging().subscribe(toTopic: "testing") { error in
          print("Subscribed to weather topic")
        }
    }
    
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self)
    private var extensionDelegate
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
        
        WKNotificationScene(controller: RemoteNotificationController.self, category: RemoteNotificationController.categoryIdentifier)
    }
}
