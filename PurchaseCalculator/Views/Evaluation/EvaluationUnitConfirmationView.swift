//
//  EvaluationUnitConfirmationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/01/2021.
//

import SwiftUI

struct EvaluationUnitConfirmationView: View {
    
    let unit: SpecificPurchaseUnit
    let item: PurchaseItem
    let evaluationManager: EvaluationManager
    @State private var buttonPressed = false
    init(unit: SpecificPurchaseUnit, item: PurchaseItem) {
        self.unit = unit
        self.item = item
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
        EmptorColorSchemeAdaptingView {
            NavigationLink("", destination: destination, isActive: $buttonPressed)
            VStack(spacing: 8) {
                ReportTitleView(text: "confirmation_report_title")
                    .padding()
                ReportRowView(title: "confirmation_report_row_0", value: item.handle, imageName: item.imageName)
                ReportRowView(title: "confirmation_report_row_1", value: unit.modelName, imageName: unit.imageName)
                ReportRowView(title: "confirmation_report_row_2", value: PriceFormatter.format(cost: unit.cost), imageName: "confirmation_report_row_2_image")
                if let evaluationCount = unit.evaluationCount,
                   evaluationCount > 0 {
                    ReportRowView(title: "confirmation_report_row_3", value: String(evaluationCount), imageName: "confirmation_report_row_3_image")
                }
                Spacer()
                HStack(spacing: 32) {
                    DismissalButton()
                    CTAButton(text: "evaluate_cta") {
                        buttonPressed = true
                    }
                }

            }
            .padding()
        }

    }
    
}
