//
//  ReminderCellView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 16/03/23.
//

import SwiftUI

enum ReminderCellEvents {
    case onSelect
    case onInfo(Reminder)
    case onCheckToggle(Reminder)
}

struct ReminderCellView: View {
    
    let reminder: Reminder
    let isSelected: Bool
    
    let onEvent: (ReminderCellEvents) -> Void
    
    private let isCheckedDelay = Delay()
    
    @State
    private var isChecked: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    toggleCompletedState()
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
            
            Spacer()
            
            if isSelected {
                Image(systemName: "info.circle.fill")
                    .onTapGesture {
                        onEvent(.onInfo(reminder))
                    }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect)
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
    
    private func toggleCompletedState() {
        isChecked.toggle()
        
        isCheckedDelay.cancel()
        
        if reminder.isCompleted != isChecked {
            isCheckedDelay.perfom(in: 2) {
                onEvent(.onCheckToggle(reminder))
            }
        }
    }
}

struct ReminderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderCellView(reminder: PreviewData.aReminder, isSelected: false) { _ in }
    }
}
