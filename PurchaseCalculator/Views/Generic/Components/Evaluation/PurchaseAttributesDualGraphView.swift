//
//  PurchaseAttributesDualGraphView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 26/12/2020.
//

import SwiftUI
import SystemKit

struct PurchaseAttributesDualGraphView: View {
    
    var attributeEvaluations: [EvaluationManager.AttributeEvaluation]
    @Binding var selectedEvaluation: EvaluationManager.AttributeEvaluation
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom) {
                ForEach(attributeEvaluations, id: \.attributeName) { evaluation in
                    PurchaseAttributeSingleDualGraphView(evaluation: evaluation, selected: evaluation == selectedEvaluation) {
                        selectedEvaluation = evaluation
                        HapticManager.performBasicHaptic(type: .rigid)
                    }
                }
            }
        }
    }
}
