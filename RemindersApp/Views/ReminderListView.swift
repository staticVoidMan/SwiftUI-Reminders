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
        List {
            ForEach(reminders) { reminder in
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
            .onDelete(perform: deleteReminders(in:))
        }
        .sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    private func deleteReminders(in set: IndexSet) {
        set.forEach { index in
            do {
                try RemindersService.delete(reminder: reminders[index])
            } catch {
                print(error)
            }
        }
    }
}

struct ReminderListView_Preview: PreviewProvider {
    
    private struct ContainerView: View {
        
        @FetchRequest(sortDescriptors: [])
        private var reminders: FetchedResults<Reminder>
        
        var body: some View {
            ReminderListView(reminders: reminders)
        }
    }
    
    static var previews: some View {
        ContainerView()
            .environment(\.managedObjectContext, RemindersService.context)
    }
}
