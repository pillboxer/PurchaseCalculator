//
//  DismissalButton.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 11/01/2021.
//

import SwiftUI

struct DismissalButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    var handler: (() -> Void)?
    
    var body: some View {
        CTAButton(text: "dismiss_cta", animationPeriod: nil, width: 100) {
            presentationMode.wrappedValue.dismiss()
            handler?()
        }
    }
    
}
