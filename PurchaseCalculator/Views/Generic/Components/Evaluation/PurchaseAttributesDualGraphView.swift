//
//  PurchaseAttributesDualGraphView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 26/12/2020.
//

import SwiftUI
import SystemKit

struct PurchaseAttributesDualGraphView: View {
    
    var attributeEvaluations: [AttributeEvaluation]
    @Binding var selectedEvaluation: AttributeEvaluation
    @Binding var animationComplete: Bool
    
    // FIXME: - 
    var height: CGFloat {
        CGFloat(attributeEvaluations.sorted {$0.attributeScore > $1.attributeScore}.first!.attributeScore * Double(UIScreen.main.bounds.height) * 0.08)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom) {
                ForEach(attributeEvaluations, id: \.attributeName) { evaluation in
                    PurchaseAttributeSingleDualGraphView(evaluation: evaluation, selected: evaluation == selectedEvaluation, height: height, barAnimationComplete: $animationComplete) {
                        selectedEvaluation = evaluation
                        HapticManager.performBasicHaptic(type: .rigid)
                    }
                }
            }
        }
    }
}
