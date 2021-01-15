//
//  AnimatingButton.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 09/01/2021.
//

import SwiftUI
import Combine

extension CTAButton where ButtonStyle == PulsingButtonStyle {
    
    init(text: String,
         imageWrapper: ImageWrapper? = nil,
         animationSpeed: Double = 0.1,
         animationPeriod: Double? = 5.0,
         animateOnTap: Bool = true,
         hiddenTuple: (hidden: Bool, unhideHandler: (() -> Void)?) = (false, nil),
         wideButton: Bool = false,
         width: CGFloat? = nil,
         height: CGFloat? = nil,
         buttonAction: @escaping () -> Void) {
        
        self.init(buttonStyle: ButtonStyle.self,
                  text: text,
                  imageWrapper: imageWrapper,
                  animationSpeed: animationSpeed,
                  animationPeriod: animationPeriod,
                  animateOnTap: animateOnTap,
                  hiddenTuple: hiddenTuple,
                  wideButton: wideButton,
                  width: width,
                  height: height,
                  buttonAction: buttonAction)
    }

}

struct ImageWrapper {
    let name: String
    var renderingMode: Image.TemplateRenderingMode = .original
}

struct CTAButton<ButtonStyle: AnimatingButtonStyle>: View {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    var buttonStyle: ButtonStyle.Type
    
    let text: String
    var imageWrapper: ImageWrapper?
    
    var animationSpeed: Double
    var animationPeriod: Double?
    var animateOnTap: Bool
    var hiddenTuple: (hidden: Bool, unhideHandler: (() -> Void)?)

    let wideButton: Bool
    var width: CGFloat?
    var height: CGFloat?
    
    let buttonAction: () -> Void
    
    @State private var animation = 1.0
    @State private var isPressing = false
    @State private var scale: CGFloat = 0.1
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(buttonStyle: ButtonStyle.Type,
         text: String,
         imageWrapper: ImageWrapper?,
         animationSpeed: Double,
         animationPeriod: Double?,
         animateOnTap: Bool,
         hiddenTuple: (hidden: Bool, unhideHandler: (() -> Void)?),
         wideButton: Bool,
         width: CGFloat?,
         height: CGFloat?,
         buttonAction: @escaping () -> Void) {
        
        self.hiddenTuple = hiddenTuple
        self.timer = Timer.publish(every: animationPeriod ?? 0, on: RunLoop.main, in: .common).autoconnect()
        self.buttonStyle = buttonStyle.self
        self.text = text
        self.imageWrapper = imageWrapper
        self.animationSpeed = animationSpeed
        self.animationPeriod = animationPeriod
        self.animateOnTap = animateOnTap
        self.wideButton = wideButton
        self.width = width
        self.height = height
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button(action: tapHandler) { buttonView }
        .buttonStyle(buttonStyle.init(animation: animation, width: width, height: height, wideButton: wideButton, disabled: !isEnabled))
        .onReceive(timer, perform: { (_) in handleTimer() })
        .scaleEffect(hiddenTuple.hidden ? scale : 1)
        .onAppear {
            if hiddenTuple.hidden {
                withAnimation(.linear(duration: 0.3) ) { scale = 1.1  }
            }
        }
        .onAnimationCompleted(for: animation) { handleAnimationComplete() }
        .onAnimationCompleted(for: scale) {
            withAnimation { scale = 1 }
            hiddenTuple.unhideHandler?()
        }
    }

    private var buttonView: some View {
        VStack {
            if let wrapper = imageWrapper {
                Image(wrapper.name)
                    .resizable()
                    .renderingMode(wrapper.renderingMode)
                    .frame(width: 25, height: 25)
                    .padding(8)
            }
            if let text = text {
                Label(String.forKey(text))
            }
        }
    }
    
    private func animateTo(_ value: Double) {
        withAnimation(.easeOut(duration: animationSpeed)) { animation = value }
    }
}

// MARK: - Handlers
extension CTAButton {
    
    private var tapHandler: () -> Void {
        return {
            if animateOnTap {
                isPressing = true
                withAnimation(.linear(duration: animationSpeed)) { animation = 0.9 }
            }
        }
    }
    
    private func handleAnimationComplete() {
        if isPressing {
            isPressing = false
            buttonAction()
        }
        animateTo(1)
    }
    
    private func handleTimer() {
        guard animationPeriod != nil && isEnabled else {
            return
        }
        animateTo(1.05)
    }

}
