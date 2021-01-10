//
//  CTAButtonStyle.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 09/01/2021.
//

import SwiftUI
import SystemKit

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
            .fixedSize()
            .padding()
            .frame(maxWidth: width, maxHeight: height)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.colorSchemeConsidered)
                    .shadow(color: Color.ctaTrailingShadow, radius: 10, x: 10, y: 10)
    
            )
            .shadow(color: Color.ctaLeadingShadow, radius: 30, x: 0, y: 0)
            .scaleEffect(CGFloat(animation))
    }
    
}
