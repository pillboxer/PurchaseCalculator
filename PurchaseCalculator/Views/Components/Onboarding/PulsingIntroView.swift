//
//  PulsingIntroView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 30/12/2020.
//

import SwiftUI

struct PulsingIntroView: View {
    
    @State private var opacity: Double = 0
    var viewModel: AttributesDetailsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Label(viewModel.labelText)
                .animation(.none)
                .frame(maxWidth: 300)
            Spacer()
        }
        .opacity(opacity)
        .onAppear {
            increaseOpacity()
        }
        .onAnimationCompleted(for: opacity) {
            if opacity == 0 {
                viewModel.changeContext()
                increaseOpacity()
            }
            else {
                reduceOpacity()
            }
        }
    }
    
    private func reduceOpacity() {
        withAnimation(.linear(duration: viewModel.pulsingDuration)) { opacity = 0 }
    }
    
    private func increaseOpacity() {
        withAnimation(.linear(duration: viewModel.pulsingDuration)) { opacity = 1 }
    }
}
