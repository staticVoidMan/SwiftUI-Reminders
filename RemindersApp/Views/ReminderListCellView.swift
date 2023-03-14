//
//  ReminderListCellView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 14/03/23.
//

import SwiftUI

struct ReminderListCellView: View {
    
    let reminderList: MyList
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle")
                .foregroundColor(Color(reminderList.color))
            
            Text(reminderList.name)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .opacity(0.4)
        }
    }
}

struct ReminderListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListCellView(
            reminderList: PreviewData.reminderLists
        )
    }
}
