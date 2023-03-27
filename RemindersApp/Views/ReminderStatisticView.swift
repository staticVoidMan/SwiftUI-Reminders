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
        .background(.gray)
        .foregroundColor(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
    }
}

struct ReminderStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderStatisticView(
            title: "Today",
            count: 99,
            iconName: "calendar",
            iconColor: .blue
        )
            .previewLayout(.sizeThatFits)
    }
}
