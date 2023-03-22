//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 16/03/23.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                case .onSelect:
                    print("ON SELECT")
                case let .onCheckToggle(reminder):
                    var config = ReminderEditConfig(with: reminder)
                    config.isCompleted.toggle()
                    
                    do {
                        try RemindersService.update(reminder: reminder, with: config)
                    } catch {
                        print(error)
                    }
                case let .onInfo(reminder):
                    print("ON INFO")
                }
            }
        }
    }
}
