//
//  HomeView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 20/02/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Hello, World!")
            
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
                        print(name, color)
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
    }
}
