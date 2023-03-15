//
//  ReminderListDetailView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 15/03/23.
//

import SwiftUI

struct ReminderListDetailView: View {
    
    let list: MyList
    
    @State var openAddReminder: Bool = false
    @State var title: String = ""
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    var body: some View {
        VStack {
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
