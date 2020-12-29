//
//  ExplanationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import SwiftUI

struct ExplanationView: View {
    
    @ObservedObject private var viewModel = ExplanationViewModel()
    @State private var opacity: Double = 1
    private let duration: Double = 2
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            if let imageName = viewModel.imageName {
                Image(imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
            }
            PCTextView(viewModel.labelText)
        }
        .opacity(opacity)
        .onReceive(timer, perform: { _ in
            reduceOpacity()
        })
        .onAnimationCompleted(for: opacity) {
            if opacity == 0 {
                viewModel.changeContext()
                increaseOpacity()
            }
        }
    }
    
    private func reduceOpacity() {
        withAnimation(.linear(duration: duration)) { opacity = 0 }
    }
    
    private func increaseOpacity() {
        withAnimation(.linear(duration: duration)) { opacity = 1 }
    }
    
}
