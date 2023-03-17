//
//  AddNewListView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 21/02/23.
//

import SwiftUI

struct AddNewListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private(set) var name: String = ""
    @State private(set) var color: Color = .red
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    let onSave: (String, Color) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image(systemName: "line.3.horizontal.circle")
                        .foregroundColor(color)
                        .font(.system(size: 100))
                    TextField("List Name", text: $name)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                }
                
                ColorPickerView(selectedColor: $color)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New List")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        onSave(name, color)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

struct AddNewListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNewListView(
                onSave: { _, _ in }
            )
            .padding()
        }
    }
}
