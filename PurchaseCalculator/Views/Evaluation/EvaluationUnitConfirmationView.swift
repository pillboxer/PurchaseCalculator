//
//  EvaluationUnitConfirmationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/01/2021.
//

import SwiftUI

struct EvaluationUnitConfirmationView: View {
    
    let unit: SpecificPurchaseUnit
    let evaluationManager: EvaluationManager
    @State private var buttonPressed = false
    init(unit: SpecificPurchaseUnit, item: PurchaseItem) {
        self.unit = unit
        self.evaluationManager = EvaluationManager(item: item)
    }
    
    @ViewBuilder
    var destination: some View {
        if let evaluation = evaluationManager.evaluateUnit(unit),
           let selectedEvaluation = evaluation.attributeEvaluations.first {
            EvaluationCalculationView(evaluation: evaluation, unitName: unit.modelName, selectedAttributeEvaluation: selectedEvaluation)
        }

    }
    
    var body: some View {
        Text("confirm you want to evaluate \(unit.modelName), priced at \(PriceFormatter.format(cost: unit.cost))")
        NavigationLink("", destination: destination, isActive: $buttonPressed)
        BorderedButtonView(text: "Confirm mother fucker") {
            buttonPressed = true
        }
    }
    
    
}
