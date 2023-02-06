//
//  View+Extensions.swift
//  friendly-spork
//
//  Created by James on 6/2/2023.
//

import Foundation
import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(Color("Text"))
            .padding(10)
    }
}
