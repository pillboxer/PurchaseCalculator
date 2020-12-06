//
//  StackPopButtonWithImage.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct StackPopButtonWithImageView: View {
    
    var imageName: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ButtonWithImageView(imageName: imageName, action: {
            presentationMode.wrappedValue.dismiss()
        })
        .padding()
        .buttonStyle(PlainButtonStyle())
    }
}

