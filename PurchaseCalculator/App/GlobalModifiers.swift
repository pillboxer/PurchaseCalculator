//
//  GlobalModifiers.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI

struct StandardFontModifier: ViewModifier {
    let standardFont: Font = .system(size: 12, weight: .bold, design: .rounded)
    
    func body(content: Content) -> some View {
        content
            .font(standardFont)
    }
}
