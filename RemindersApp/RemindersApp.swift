//
//  RemindersApp.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 20/02/23.
//

import SwiftUI
import UserNotifications

@main
struct RemindersApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications enabled")
            } else {
                print("Notifications disabled: \(error?.localizedDescription ?? "")")
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, RemindersService.context)
        }
    }
}
