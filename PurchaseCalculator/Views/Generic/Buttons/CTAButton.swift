//
//  AnimatingButton.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 09/01/2021.
//

import SwiftUI
import Combine

extension CTAButton where ButtonStyle == PulsingButtonStyle {
    
    init(text: String, imageName: String? = nil, animationSpeed: Double = 0.1, animationPeriod: Double? = 5.0, animateOnTap: Bool = true, width: CGFloat? = nil, height: CGFloat? = nil, buttonAction: @escaping () -> Void) {
        self.init(buttonStyle: ButtonStyle.self, text: text, imageName: imageName, animationSpeed: animationSpeed, animationPeriod: animationPeriod, animateOnTap: animateOnTap, width: width, height: height, buttonAction: buttonAction)
    }

}

struct CTAButton<ButtonStyle: AnimatingButtonStyle>: View {
    
    var buttonStyle: ButtonStyle.Type
    
    let text: String
    var imageName: String?
    
    var animationSpeed: Double
    var animationPeriod: Double?
    var animateOnTap: Bool
    
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    
    let buttonAction: () -> Void
    
    @State private var animation = 1.0
    @State private var isPressing = false
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(buttonStyle: ButtonStyle.Type, text: String, imageName: String? = nil, animationSpeed: Double = 0.1, animationPeriod: Double? = 5.0, animateOnTap: Bool = true, width: CGFloat? = nil, height: CGFloat? = nil, buttonAction: @escaping () -> Void) {
        self.buttonStyle = buttonStyle.self
        self.text = text
        self.imageName = imageName
        self.animationSpeed = animationSpeed
        self.animationPeriod = animationPeriod
        self.animateOnTap = animateOnTap
        self.width = width
        self.height = height
        self.buttonAction = buttonAction
        timer = Timer.publish(every: animationPeriod ?? 0, on: RunLoop.main, in: .common).autoconnect()
    }
    
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
            guard animationPeriod != nil else {
                return
            }
            animateTo(1.05)
        })
    }
    
    func animateTo(_ value: Double) {
        withAnimation(.easeOut(duration: animationSpeed)) { animation = value }

    }
    
    
}
