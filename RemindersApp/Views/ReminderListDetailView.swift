//
//  ReminderListDetailView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 15/03/23.
//

import SwiftUI

struct ReminderListDetailView: View {
    
    private let list: MyList
    
    @FetchRequest(sortDescriptors: [])
    private var reminders: FetchedResults<Reminder>
    
    @State var openAddReminder: Bool = false
    @State var title: String = ""
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    init(list: MyList) {
        self.list = list
        self._reminders = FetchRequest(fetchRequest: RemindersService.getReminders(inList: list))
    }
    
    var body: some View {
        VStack {
            ReminderListView(reminders: reminders)
            
            Spacer()
            
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Add Reminder")
            }
            .foregroundColor(.blue)
            .padding()
            .onTapGesture {
                openAddReminder = true
            }
        }
        .alert("New Reminder" ,isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {}
            Button("Done") {
                if isFormValid {
                    do {
                        try RemindersService.saveReminder(to: list, title: title)
                        title = ""
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

struct ReminderListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListDetailView(list: PreviewData.reminderLists)
    }
}
