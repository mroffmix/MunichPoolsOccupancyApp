//
//  CounterApp.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import SwiftUI

@main
struct CounterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: CounterVM(service: CounterService(for: "/api/gates/counter")))
        }
    }
}
