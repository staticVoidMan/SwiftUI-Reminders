//
//  ReminderDetailView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 17/03/23.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var reminder: Reminder
    @State
    private var editReminder: ReminderEditConfig = ReminderEditConfig()
    
    private var isFormValid: Bool {
        !editReminder.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
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
                            displayedComponents: .date
                        )
                    }
                    
                    Toggle(isOn: $editReminder.hasTime) {
                        Image(systemName: "clock")
                    }
                    .foregroundColor(.blue)
                    
                    if editReminder.hasTime {
                        DatePicker(
                            "Select Time",
                            selection: $editReminder.reminderTime ?? Date(),
                            displayedComponents: .hourAndMinute
                        )
                    }
                }
                .onChange(of: editReminder.hasDate) { hasDate in
                    editReminder.reminderDate = hasDate ? Date() : nil
                }
                .onChange(of: editReminder.hasTime) { hasTime in
                    editReminder.reminderTime = hasTime ? Date() : nil
                }
                
                Section {
                    NavigationLink {
                        SelectListView(selectedList: $reminder.list)
                    } label: {
                        HStack {
                            Text("Select List")
                            Spacer()
                            Text(reminder.list!.name)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        do {
                            try RemindersService.update(reminder: reminder, with: editReminder)
                            dismiss()
                        } catch {
                            print(error)
                        }
                    }
                    .disabled(!isFormValid)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
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
