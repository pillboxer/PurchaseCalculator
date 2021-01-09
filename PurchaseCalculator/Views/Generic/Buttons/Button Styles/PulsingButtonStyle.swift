//
//  CTAButtonStyle.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 09/01/2021.
//

import SwiftUI

protocol AnimatingButtonStyle: ButtonStyle {
    init(animation: Double, width: CGFloat?, height: CGFloat?)
    var width: CGFloat? { get }
    var height: CGFloat? { get }
}

struct PulsingButtonStyle: AnimatingButtonStyle {
        
    let animation: Double
    var width: CGFloat?
    var height: CGFloat?
    
    func pressedAmountFor(_ configuration: Configuration) -> CGSize {
        configuration.isPressed ? CGSize(width: 1.3, height: 1.3) : CGSize(width: 1, height: 1)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: width, maxHeight: height)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.primary, lineWidth: 3))
            .scaleEffect(CGFloat(animation))

    }
}
