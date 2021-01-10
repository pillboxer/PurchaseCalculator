//
//  WelcomeView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import SwiftUI
import PurchaseCalculatorDataKit

struct WelcomeView: View {
    
    @ObservedObject var cloudKitCoordinator: CloudKitCoordinator = CloudKitCoordinator.shared
    
    private enum Context {
        case getStarted
        case explanation
        case preferences
    }
    
    @State private var context: Context = .getStarted
    var body: some View {
        EmptorColorSchemeAdaptingView {
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
            }
        }
    }
}


