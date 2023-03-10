//
//  ColorPickerView.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 21/02/23.
//

import SwiftUI

struct ColorPickerView: View {
    
    @Binding var selectedColor: Color
    private let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                ZStack {
                    Circle()
                        .foregroundColor(color)
                        .scaleEffect(CGSize(width: 0.8, height: 0.8))
                    Circle()
                        .strokeBorder(
                            color == selectedColor ? color : .clear,
                            lineWidth: 3
                        )
                }
                .onTapGesture { selectedColor = color }
            }
        }
        .frame(height: 100)
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(selectedColor: .constant(.red))
    }
}
