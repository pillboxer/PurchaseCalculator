//
//  AnimatingButton.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 09/01/2021.
//

import SwiftUI

struct CTAButton: View {
    
    let buttonStyle = PulsingButtonStyle.self
    
    let text: String
    var imageName: String? = nil
    
    let animationSpeed: Double = 0.1
    var periodicAnimation: Bool = false
    let animateOnTap: Bool = true
    
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    
    let buttonAction: () -> Void
    
    
    @State private var animation = 1.0
    @State private var isPressing = false
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Button(action: {
            if animateOnTap {
                isPressing = true
                withAnimation(.linear(duration: animationSpeed)) { animation = 0.9 }
            }
        }) {
            VStack {
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 25, height: 25)
                }
                if let text = text {
                    Label(String.forKey(text))
                        .padding(.top, imageName == nil ? 0 : 4)

                }
                if let _ = imageName {
                }
            }
        }
        .buttonStyle(buttonStyle.init(animation: animation, width: width, height: height))
        .onAnimationCompleted(for: animation) {
            if isPressing {
                isPressing = false
                buttonAction()
            }
            animateTo(1)
        }
        .onReceive(timer, perform: { _ in
            guard periodicAnimation else {
                return
            }
            animateTo(1.05)
        })
    }
    
    func animateTo(_ value: Double) {
        withAnimation(.easeOut(duration: animationSpeed)) { animation = value }

    }
    
    
}
