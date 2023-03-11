//
//  View+Extensions.swift
//  friendly-spork
//
//  Created by James on 6/2/2023.
//

import UIKit
import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(Theme.Color.text)
            .padding(10)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorners(radius: radius, corners: corners) )
    }
}
