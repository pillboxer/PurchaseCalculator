//
//  GlobalModifiers.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI

struct StandardFontModifier: ViewModifier {
    
    var size: CGFloat?
    
    func body(content: Content) -> some View {
        let standardFont: Font = .system(size: size ?? 12, weight: .bold, design: .rounded)
        return content
            .font(standardFont)
    }
}

struct AnimationCompletionModifier<T: VectorArithmetic>: AnimatableModifier {
    
    // MARK: - Conformance
    var animatableData: T {
        didSet {
            notifyOfFinishIfNecessary()
        }
    }
    
    // MARK: - Initialisation
    init(observedValue: T, completion: @escaping () -> Void) {
        self.completionHandler = completion
        self.animatableData = observedValue
        self.targetValue = observedValue
        
    }
    
    // MARK: - Properties
    private var completionHandler: () -> Void
    private var targetValue: T
    
    // MARK: - Methods
    private func notifyOfFinishIfNecessary() {
        if animatableData == targetValue {
            DispatchQueue.main.async {
                self.completionHandler()
            }
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}


extension View {

    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionModifier<Value>> {
        return modifier(AnimationCompletionModifier(observedValue: value, completion: completion))
    }
    
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
            case true:
                self.hidden()
            case false:
                self
        }
    }
}
