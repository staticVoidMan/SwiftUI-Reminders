//
//  ReminderCellView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 16/03/23.
//

import SwiftUI

struct ReminderCellView: View {
    
    let reminder: Reminder
    
    @State
    private var isChecked: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    isChecked.toggle()
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .opacity(0.4)
                }
                
                HStack {
                    if let date = getRelativeDate() {
                        Text(date)
                    }
                    
                    if let time = getTime() {
                        Text(time)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
        }
    }
    
    private func getRelativeDate() -> String? {
        guard let date = reminder.reminderDate else { return nil }
        
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    private func getTime() -> String? {
        guard let date = reminder.reminderTime else { return nil }
        return date.formatted(date: .omitted, time: .shortened)
    }
}

struct ReminderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderCellView(reminder: PreviewData.reminder)
    }
}
