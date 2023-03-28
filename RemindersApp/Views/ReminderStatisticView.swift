//
//  ReminderStatisticView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 27/03/23.
//

import SwiftUI

struct ReminderStatisticView: View {
    
    let title: String
    let count: Int
    
    let iconName: String
    let iconColor: Color
    
    @Environment(\.colorScheme)
    private var colorScheme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: iconName)
                    .font(.title)
                    .foregroundColor(iconColor)
                Text(title)
                    .opacity(0.8)
            }
            
            Spacer()
            
            Text("\(count)")
                .font(.largeTitle)
        }
        .padding()
        .background(colorScheme == .dark ? Color.darkGray : .offWhite)
        .foregroundColor(colorScheme == .dark ? Color.offWhite : .darkGray)
        .clipShape(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
    }
}

struct ReminderStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ReminderStatisticView(
                title: "Today",
                count: 99,
                iconName: "calendar",
                iconColor: .blue
            )
            .environment(\.colorScheme, .dark)
            ReminderStatisticView(
                title: "Today",
                count: 99,
                iconName: "calendar",
                iconColor: .blue
            )
            .environment(\.colorScheme, .light)
        }
        .previewLayout(.sizeThatFits)
    }
}
