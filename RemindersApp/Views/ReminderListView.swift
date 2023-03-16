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
            ReminderCellView(reminder: reminder)
        }
    }
}
