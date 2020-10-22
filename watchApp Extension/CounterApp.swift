//
//  CounterApp.swift
//  watchApp Extension
//
//  Created by Ilya on 22.10.20.
//

import SwiftUI

@main
struct CounterApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(vm: CounterVM(service: CounterService(for: "/api/gates/counter")))
            }
        }
        
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
