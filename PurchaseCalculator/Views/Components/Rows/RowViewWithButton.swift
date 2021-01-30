//
//  RowViewWithButton.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI
import PurchaseCalculatorDataKit

struct RowViewWithButton: View {
    
    let title: String
    let imageName: String
    
    var buttonRotation: Double = 0
    
    var buttonImageName: String = "arrow.right.circle"
    var buttonHandler: () -> Void
    
    var body: some View {
        HStack {
            Image(named: imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 20, maxHeight: 20)
                .padding(.trailing)
            Label(title)
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
