//
//  GetStartedView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import SwiftUI

struct GetStartedView: View {
    
    @State var opacity: Double = 1
    
    var animationCompleteHandler: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            AttributeIconsGroupView()
                .padding()
            PCTextView("Welcome to Oliver")
            Spacer()
            BorderedButtonView(text: "Get started") {
                withAnimation(.linear(duration: 1)) { opacity = 0 }
            }
            .frame(width: 100, height: 50)
            .padding()
        }
        .onAnimationCompleted(for: opacity) {
            withAnimation { animationCompleteHandler() }
        }
        .opacity(opacity)
    }
    
}
