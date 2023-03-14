//
//  RemindersApp.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 20/02/23.
//

import SwiftUI

@main
struct RemindersApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, RemindersService.context)
        }
    }
}
