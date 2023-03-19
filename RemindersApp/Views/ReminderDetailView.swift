//
//  ReminderDetailView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 17/03/23.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Binding var reminder: Reminder
    @State
    private var editReminder: ReminderEditConfig = ReminderEditConfig()
    
    var body: some View {
        List {
            Section {
                TextField("Title", text: $editReminder.title)
                TextField("Notes", text: $editReminder.notes ?? "")
            }
            
            Section {
                Toggle(isOn: $editReminder.hasDate) {
                    Image(systemName: "calendar")
                }
                .foregroundColor(.red)
                
                if editReminder.hasDate {
                    DatePicker(
                        "Select Date",
                        selection: $editReminder.reminderDate ?? Date(),
                        displayedComponents: .date)
                }
                
                Toggle(isOn: $editReminder.hasTime) {
                    Image(systemName: "clock")
                }
                .foregroundColor(.blue)
                
                if editReminder.hasTime {
                    DatePicker(
                        "Select Time",
                        selection: $editReminder.reminderTime ?? Date(),
                        displayedComponents: .hourAndMinute)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Details")
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    print(#function)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    print(#function)
                }
            }
        }
        .onAppear {
            editReminder = ReminderEditConfig(with: reminder)
        }
    }
}

struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReminderDetailView(reminder: .constant(PreviewData.aReminder))
        }
    }
}
