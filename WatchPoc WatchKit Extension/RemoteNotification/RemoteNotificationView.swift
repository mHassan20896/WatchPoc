//
//  RemoteNotificationView.swift
//  WatchPoc WatchKit Extension
//
//  Created by VenD-Hassan on 2/4/22.
//

import SwiftUI

struct RemoteNotificationView: View {
    @State private var showDetails = false
    
    let model: RemoteNotificationModel
    
    var body: some View {
        ScrollView {
            Text(model.title)
                .font(.title2)
            
            Text(model.details)
                .font(.caption2)
        }
    }
}

struct RemoteNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteNotificationView(
            model: RemoteNotificationModel(
                title: "Baad Me",
                details: "This is a demo app"
            )
        )
    }
}

