//
//  SingleBarView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 26/12/2020.
//

import SwiftUI

struct SingleBarViewAnimated: View {
    
    @State private var _height: CGFloat = 0
    
    let height: Double
    let width: CGFloat
    let color: Color
    
    @Binding var animationComplete: Bool
    
    var endingHeight: CGFloat {
        CGFloat(height)
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(width: width, height: _height)
            .onAppear {
                guard !animationComplete else {
                    _height = endingHeight
                    return
                }
                withAnimation(.easeIn(duration: 1)) { _height = endingHeight }
            }
            .onAnimationCompleted(for: _height) {
                animationComplete = true
            }
            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.primary))
    }
}

struct SingleBarView: View {
    
    let height: Double
    let width: Double
    let color: Color
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(width: CGFloat(width), height: CGFloat(height))
            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.primary))
    }
    
}
