//
//  SelectListView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 19/03/23.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var allLists: FetchedResults<MyList>
    
    @Binding var selectedList: MyList?
    
    var body: some View {
        List(allLists) { list in
            HStack {
                Image(systemName: "line.3.horizontal.circle")
                    .foregroundColor(Color(list.color))
                
                Text(list.name)
                
                Spacer()
                
                if list == selectedList {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.selectedList = list
            }
        }
    }
}

struct SelectListView_Previews: PreviewProvider {
    static var previews: some View {
        SelectListView(selectedList: .constant(PreviewData.aList))
            .environment(\.managedObjectContext, RemindersService.context)
    }
}
