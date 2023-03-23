//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 16/03/23.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    @State
    private var selectedReminder: Reminder?
    
    @State
    private var showReminderDetail: Bool = false
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(
                reminder: reminder,
                isSelected: isReminderSelected(reminder)
            ) { event in
                switch event {
                case .onSelect:
                    selectedReminder = reminder
                case let .onCheckToggle(reminder):
                    var config = ReminderEditConfig(with: reminder)
                    config.isCompleted.toggle()
                    
                    do {
                        try RemindersService.update(reminder: reminder, with: config)
                    } catch {
                        print(error)
                    }
                case .onInfo:
                    showReminderDetail = true
                }
            }
        }
        .sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
}
