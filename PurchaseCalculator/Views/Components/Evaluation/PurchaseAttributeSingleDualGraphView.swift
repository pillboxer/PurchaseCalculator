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
    
    var evaluation: AttributeEvaluation
    var selected: Bool
    var height: CGFloat
    @Binding var barAnimationComplete: Bool

    var selectionHandler: () -> Void
    
    private func barHeight(for score: Double) -> Double {
        max(2, Double(height) * score)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                SingleBarViewAnimated(height: barHeight(for: evaluation.attributeResult.colorScore),
                              width: 10,
                              color: ColorManager.evaulationResultColorFor(evaluation.attributeResult),
                              animationComplete: $barAnimationComplete)
                SingleBarViewAnimated(height: barHeight(for: evaluation.userWeighting.colorScore),
                              width: 10,
                              color: .gray,
                              animationComplete: $barAnimationComplete)
            }
            .frame(height: height, alignment: .bottom)
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
                .fill(Color.primary)
                .frame(width: 25, height: 2)
                .padding(2)
                .hidden(!selected)
        }
        .opacity(selected ? 1 : 0.35)
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
