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
        NavigationStack {
            ForEach(lists, id: \.self) { list in
                NavigationLink(value: list) {
                    VStack {
                        ReminderListCellView(reminderList: list)
                            .padding([.leading, .trailing])
                            .padding([.top, .bottom], 8)
                        Divider()
                    }
                }
            }
            .navigationDestination(for: MyList.self) { list in
                ReminderListDetailView(list: list)
                    .navigationTitle(list.name)
            }
        }
    }
}

//struct ReminderListsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderListsView()
//    }
//}
