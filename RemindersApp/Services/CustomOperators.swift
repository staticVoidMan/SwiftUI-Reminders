//
//  CustomOperators.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 18/03/23.
//

import SwiftUI

public func ??<T>(lhs: Binding<T?>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
