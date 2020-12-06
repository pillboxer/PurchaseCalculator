//
//  ButtonWithImageView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct ButtonWithImageView: View {
    
    var imageName: String
    var systemImage: Bool = true
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            systemImage ? Image(systemName: imageName) : Image(imageName)
                .resizable()
        }
        .buttonStyle(PlainButtonStyle())
    }
}
