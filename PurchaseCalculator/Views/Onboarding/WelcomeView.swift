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
        case preferences
    }
    
    @State private var context: Context = .getStarted
    
    var body: some View {
        if context == .getStarted {
            GetStartedView() {
                context = .explanation
            }
        }
        else if context == .explanation {
            AttributesDetailsView() {
                withAnimation { context = .preferences }
            }
        }
        else {
            HomescreenView()
//                .transition(AnyTransition.opacity.animation(.linear(duration: 2)))
        }
    }
}


