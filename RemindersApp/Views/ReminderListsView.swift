//
//  ReminderListsView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 14/03/23.
//

import SwiftUI

struct ReminderListsView: View {
    
    let lists: FetchedResults<MyList>
    
    var body: some View {
        ForEach(lists, id: \.self) { list in
            VStack {
                ReminderListCellView(reminderList: list)
                    .padding([.leading, .trailing])
                    .padding([.top, .bottom], 8)
                Divider()
            }
        }
    }
}

//struct ReminderListsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderListsView()
//    }
//}
