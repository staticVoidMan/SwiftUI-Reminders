//
//  HomeView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 20/02/23.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var reminderLists: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResult: FetchedResults<Reminder>
    
    @State
    private var isPresented: Bool = false
    
    @State
    private var searchTerm: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ReminderListsView(lists: reminderLists)
                
                Spacer()
                
                Button("Add List") {
                    isPresented = true
                }
                .font(.headline)
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
                .padding()
            }
            .overlay {
                if !searchTerm.isEmpty {
                    ReminderListView(reminders: searchResult)
                }
            }
        }
        .searchable(text: $searchTerm)
        .sheet(isPresented: $isPresented) {
            AddNewListView(
                onSave: { name, color in
                    do {
                        try RemindersService.saveList(
                            name: name,
                            color: UIColor(color)
                        )
                    } catch {
                        print(error)
                    }
                }
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, RemindersService.context)
    }
}
