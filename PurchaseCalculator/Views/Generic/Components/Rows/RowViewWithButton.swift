//
//  RowViewWithButton.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI

struct RowViewWithButton: View {
        
    let title: String
    let imageName: String?
    var usesSystemImage: Bool = false
    
    var buttonRotation: Double = 0
    
    var buttonImageName: String = "arrow.right.circle"
    var buttonHandler: () -> Void
    
    var image: Image {
        let name = imageName ?? "exclamationmark.triangle.fill"
        return usesSystemImage ? Image(systemName: name) : Image(name)
    }
    
    @ViewBuilder
    var body: some View {
        HStack {
            if imageName != nil {
                image
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20, maxHeight: 20)
                    .padding(.trailing)
            }
            Text(title)
                .modifier(StandardFontModifier())
            Spacer()
            Button(action: {
                buttonHandler()
            }) {
                Image(systemName: buttonImageName)
            }
            .rotationEffect(.degrees(buttonRotation))
            .accentColor(.primary)
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}
