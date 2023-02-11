//
//  Theme.swift
//  friendly-spork
//
//  Created by James on 7/2/2023.
//

import SwiftUI

public struct Theme {
    public struct Color {}
}

extension Theme.Color {
    static let blue: Color = Color("Blue")
    static let green: Color = Color("Green")
    static let sage: Color = Color("Sage")
    static let navy: Color = Color("Navy")
    static let red: Color = Color("Red")
    static let yellow: Color = Color("Yellow")
    
    static let text: Color = Color("Text")
    static let textSupp: Color = Color("TextSupp")
    static let textHard: Color = Color("TextHard")
    static let textHardSupp: Color = Color("TextHardSupp")
    
    static let background: Color = Color("Background")
    static let backgroundSupp: Color = Color("BackgroundSupp")
    
    static let colorArray: [Color] = [
        Theme.Color.blue,
        Theme.Color.green,
        Theme.Color.sage,
        Theme.Color.navy
    ]
}
