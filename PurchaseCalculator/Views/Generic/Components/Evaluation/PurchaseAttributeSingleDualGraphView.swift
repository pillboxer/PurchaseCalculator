//
//  PurchaseAttributeSingleDualGraphView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 26/12/2020.
//

import SwiftUI
import SystemKit
struct PurchaseAttributeSingleDualGraphView: View {
    
    @State private var scale: Double = 1
    @State private var imageTapped: Bool = false
    @State private var barAnimationComplete: Bool = false
    
    var evaluation: EvaluationManager.AttributeEvaluation
    var selected: Bool
    var height: Double = 100
    var selectionHandler: () -> Void
    
    func barHeight(for score: Double) -> Double {
        (height / 2) * score
    }
    
    var body: some View {
        VStack {
            let result = evaluation.attributeResult
            HStack(alignment: .bottom) {
                SingleBarViewAnimated(height: barHeight(for: evaluation.attributeScore),
                              width: 10,
                              color: result.evaluationColor,
                              animationComplete: $barAnimationComplete)
                SingleBarViewAnimated(height: barHeight(for: evaluation.userWeighting.score),
                              width: 10,
                              color: .gray,
                              animationComplete: $barAnimationComplete)
            }
            .padding(5)
            .frame(height: CGFloat(height), alignment: .bottom)
            Image(evaluation.attributeImageName)
                .resizable()
                .frame(width: 25, height: 25)
                .scaleEffect(CGSize(width: scale, height: scale))
                .onTapGesture {
                    if !selected {
                        imageTapped = true
                        selectionHandler()
                    }
                }
            Rectangle()
                .fill(result.evaluationColor)
                .frame(width: 25, height: 2)
                .padding(2)
                .hidden(!selected)
        }
        .onChange(of: barAnimationComplete, perform: { value in
            HapticManager.performFeedbackHaptic(.success)
            withAnimation { scale = 1.5 }
        })
        .onChange(of: imageTapped, perform: { value in
            if imageTapped {
                withAnimation { scale = 1.5 }
            }
        })
        .onAnimationCompleted(for: scale) {
            guard scale > 1 else {
                return
            }
            imageTapped = false
            withAnimation {
                scale = 1
            }
        }
    }
}
