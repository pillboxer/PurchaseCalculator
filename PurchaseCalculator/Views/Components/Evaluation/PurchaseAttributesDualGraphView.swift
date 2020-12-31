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
    
    var graphHeight: CGFloat {
        guard let topAttribute = attributeEvaluations.sorted(by: {$0.attributeScore > $1.attributeScore}).first?.attributeScore,
              let topWeighting = attributeEvaluations.sorted(by: {$0.userWeighting.score > $1.userWeighting.score}).first?.userWeighting.score else {
            return 150
        }
        let highestGraph = CGFloat(max(topAttribute, topWeighting))
        let height = min(highestGraph * UIScreen.main.bounds.height * 0.075, 150)
        return height
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Spacer()
                ForEach(attributeEvaluations, id: \.attributeName) { evaluation in
                    PurchaseAttributeSingleDualGraphView(evaluation: evaluation, selected: evaluation == selectedEvaluation, height: graphHeight, barAnimationComplete: $animationComplete) {
                        selectedEvaluation = evaluation
                        HapticManager.performBasicHaptic(type: .rigid)
                    }
                    Spacer()
                }
            }
            .padding()
        }
        
    }
}
