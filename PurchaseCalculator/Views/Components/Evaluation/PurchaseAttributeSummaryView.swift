//
//  PurchaseAttributeSummaryView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 26/12/2020.
//

import SwiftUI
import SystemKit

struct PurchaseAttributeSummaryView: View {
    
    enum PurchaseAttributeSummaryContext: Equatable {
        case basic
        case detailed(_ top: Bool)
        
        func toggled(_ topSelected: Bool?) -> PurchaseAttributeSummaryContext {
            guard let topSelected = topSelected else {
                return .basic
            }
            return .detailed(topSelected)
        }
        
        var isTop: Bool {
            switch self {
            case .basic:
                return false
            case .detailed(let isTop):
                return isTop
            }
        }
    }
    
    @State private var context: PurchaseAttributeSummaryContext = .basic
    @State private var opacity: Double = 1
    @State private var degrees: Double = 0
    var selectedEvaluation: AttributeEvaluation
    var itemName: String
    
    @ViewBuilder
    var viewForContext: some View {
        if context == .basic {
            BasicSummaryView(selectedEvaluation: selectedEvaluation) { isTop in
                changeContext(isTop)
            }
        }
        else {
            DetailedSummaryView(selectedEvaluation: selectedEvaluation, itemName: itemName, topSelected: context.isTop) {
                changeContext(nil)
            }
        }
    }
    
    var body: some View {
        viewForContext
            .rotation3DEffect(
                .degrees(degrees),
                axis: (x: 0.0, y: 1.0, z: 0))
            .opacity(opacity)
            .frame( maxHeight: 100)
            .onAnimationCompleted(for: opacity) {
                degrees = 0
                withAnimation(.easeIn(duration: 0.2)) { opacity = 1 }
            }
    }
    
    private func changeContext(_ topSelected: Bool?) {
        withAnimation(.easeIn(duration: 0.2)) {
            degrees = topSelected == nil ? -180 : 180
            opacity = 0
            context = context.toggled(topSelected)
            HapticManager.performFeedbackHaptic(.success)
        }
    }
}

struct ImageAndTextView: View {
    
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.bottom, 4)
            Label(text)
        }
    }
    
}

struct CircleAndTextView: View {
    
    var text: String
    var color: Color
    var inspectionHandler: (() -> Void)?
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            Label(text)
            if let inspectionHandler = inspectionHandler {
                Image("question")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .onTapGesture {
                        inspectionHandler()
                    }
            }
        }
    }
    
}
