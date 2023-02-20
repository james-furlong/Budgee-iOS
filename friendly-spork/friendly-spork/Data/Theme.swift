//
//  Theme.swift
//  friendly-spork
//
//  Created by James on 7/2/2023.
//

import SwiftUI

public struct Theme {
    public struct Color {}
    public struct Font {}
}

extension Theme.Color {
    static let teal: Color = Color("Teal")
    static let navy: Color = Color("Navy")
    static let red: Color = Color("Red")
    static let yellow: Color = Color("Yellow")
    static let orange: Color = Color("Orange")
    
    static let text: Color = Color("Text")
    static let textSupp: Color = Color("TextSupp")
    static let textHard: Color = Color("TextHard")
    static let textHardSupp: Color = Color("TextHardSupp")
    
    static let background: Color = Color("Background")
    static let backgroundSupp: Color = Color("BackgroundSupp")
    static let backgroundCell: Color = Color("BackgroundCell")
}

extension Theme.Font {
    static let header: Font = Font.custom("lazy_dog", size: 25)
}
