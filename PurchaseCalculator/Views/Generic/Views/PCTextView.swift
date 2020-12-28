//
//  PCTextView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 25/12/2020.
//

import SwiftUI

struct PCTextView: View {
    
    var text: String
    var size: CGFloat?
    
    init(_ text: String, size: CGFloat? = nil) {
        self.text = text
        self.size = size
    }
    
    var body: some View {
        Text(text)
            .modifier(StandardFontModifier(size: size))
    }
    
}
