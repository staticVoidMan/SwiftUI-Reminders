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
    
    @FetchRequest(fetchRequest: RemindersService.filterReminders(forStatistic: .today))
    private var todayReminders: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.filterReminders(forStatistic: .scheduled))
    private var scheduledReminders: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.filterReminders(forStatistic: .all))
    private var allReminders: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.filterReminders(forStatistic: .completed))
    private var completedReminders: FetchedResults<Reminder>
    
    @State
    private var isPresented: Bool = false
    
    @State
    private var searchTerm: String = ""
    
    @State
    private var reminderStatistics: ReminderStatistics = ReminderStatistics()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: todayReminders)
                        } label: {
                            ReminderStatisticView(
                                title: "Today",
                                count: reminderStatistics.today,
                                iconName: "calendar",
                                iconColor: .blue
                            )
                        }

                        NavigationLink {
                            ReminderListView(reminders: scheduledReminders)
                        } label: {
                            ReminderStatisticView(
                                title: "Scheduled",
                                count: reminderStatistics.scheduled,
                                iconName: "calendar.circle.fill",
                                iconColor: .red
                            )
                        }
                    }
                    
                    HStack {
                        
                        NavigationLink {
                            ReminderListView(reminders: allReminders)
                        } label: {
                            ReminderStatisticView(
                                title: "All",
                                count: reminderStatistics.all,
                                iconName: "tray.circle.fill",
                                iconColor: .secondary
                            )
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: completedReminders)
                        } label: {
                            ReminderStatisticView(
                                title: "Completed",
                                count: reminderStatistics.completed,
                                iconName: "checkmark.circle.fill",
                                iconColor: .green
                            )
                        }
                    }
                }
                .padding([.leading, .trailing])
                
                Text("My Lists")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
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
            .navigationTitle("Reminders")
        }
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm) { searchTerm in
            searchResult.nsPredicate = RemindersService
                .filterReminders(searchTerm: searchTerm)
                .predicate
        }
        .onAppear {
            reminderStatistics = ReminderStatisticsProvider.getStatistics(from: reminderLists)
        }
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
