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
    
    @State
    private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List(reminderLists, id: \.self) { list in
                Text(list.name)
            }
            
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
        .sheet(isPresented: $isPresented) {
            NavigationView {
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
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, RemindersService.context)
    }
}
