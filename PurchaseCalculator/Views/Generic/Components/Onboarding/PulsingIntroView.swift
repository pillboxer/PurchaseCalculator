//
//  PulsingIntroView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 30/12/2020.
//

import SwiftUI

struct PulsingIntroView: View {
    
    @State private var opacity: Double = 0
    var viewModel: ExplanationViewModel
    
    var body: some View {
        VStack {
            if let imageName = viewModel.pulsingImageName {
                Image(imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
            }
            Label(viewModel.labelText)
                .animation(.none)
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
