//
//  Label.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 25/12/2020.
//

import SwiftUI
import SystemKit

struct Label: View {
    
    var text: String
    var size: CGFloat?
    var underlined: Bool
    
    init(_ text: String, size: CGFloat? = nil, underlined: Bool = false) {
        self.text = String.forKey(text)
        self.size = size
        self.underlined = underlined
    }
    
    @ViewBuilder
    var body: some View {
        if underlined {
            Text(String.forKey(text))
                .underline()
                .modifier(StandardFontModifier(size: size))
        }
        else {
            Text(String.forKey(text))
                .modifier(StandardFontModifier(size: size))
        }

    }
    
}

extension Label {
    
    func underline() -> Label {
        return Label(text, size: size, underlined: true)
    }

}
