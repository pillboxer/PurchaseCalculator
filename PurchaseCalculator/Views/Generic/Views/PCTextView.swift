//
//  PCTextView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 25/12/2020.
//

import SwiftUI

struct PCTextView: View {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .modifier(StandardFontModifier())
    }
    
}
