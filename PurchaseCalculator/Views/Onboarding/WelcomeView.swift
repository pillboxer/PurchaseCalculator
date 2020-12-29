//
//  WelcomeView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import SwiftUI

struct WelcomeView: View {
    
    private enum Context {
        case getStarted
        case explanation
    }
    
    @State private var context: Context = .getStarted
    
    @State private var opacity: Double = 0
    var body: some View {
        if context == .getStarted {
            GetStartedView() {
                context = .explanation
            }
        }
        else {
            ExplanationView().transition(AnyTransition.opacity.animation(.linear(duration: 5)))
        }
    }
}


