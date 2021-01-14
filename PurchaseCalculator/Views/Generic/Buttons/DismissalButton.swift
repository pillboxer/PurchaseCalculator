//
//  DismissalButton.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 11/01/2021.
//

import SwiftUI

struct DismissalButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        EmptyView()
        CTAButton(text: "dismiss_cta", animationPeriod: nil) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
}
