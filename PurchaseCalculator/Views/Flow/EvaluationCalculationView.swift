//
//  EvaluationCalculationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 24/12/2020.
//

import SwiftUI

struct EvaluationCalculationView: View {
    
    var evaluation: EvaluationManager.Evaluation
    var unitName: String
    @State var selectedAttributeEvaluation: EvaluationManager.AttributeEvaluation
        
    var body: some View {
        VStack {
            PCTextView(unitName)
                .padding(.top)
            PurchaseAttributesDualGraphView(attributeEvaluations: evaluation.attributeEvaluations,
                                            selectedEvaluation: $selectedAttributeEvaluation)
            Divider()
            PurchaseAttributeSummaryView(selectedEvaluation: selectedAttributeEvaluation, itemName: evaluation.itemName)
            Divider()
            Rectangle()
            Rectangle()
        }

    }
    
}
