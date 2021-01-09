//
//  GetStartedView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import SwiftUI
import SystemKit
import PurchaseCalculatorDataKit

struct GetStartedView: View {
    
    @State var opacity: Double = 1
    @State var buttonPressed = false
    var animationCompleteHandler: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            AttributeIconsGroupView()
                .padding()
                .disabled(buttonPressed)
            Label("app_name")
            Spacer()
            CTAButton(text: "get_started_cta",  periodicAnimation: true, width: 100, height: 100) {
                buttonPressed = true
                HapticManager.performFeedbackHaptic(.success)
                withAnimation(.linear(duration: 1)) { opacity = 0 }
            }
            .padding()
        }
        .onAnimationCompleted(for: opacity) {
            withAnimation { animationCompleteHandler() }
        }
        .opacity(opacity)
    }
    
}
