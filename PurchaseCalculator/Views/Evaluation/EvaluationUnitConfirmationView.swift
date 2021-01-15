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
    @Binding var isActive: Bool
    
    init(unit: SpecificPurchaseUnit, item: PurchaseItem, isActive: Binding<Bool>) {
        self.unit = unit
        self.item = item
        self.evaluationManager = EvaluationManager(item: item)
        // FIXME: - What actually is this? Find out
        self._isActive = isActive
    }
    
    @ViewBuilder
    var destination: some View {
        if let evaluation = evaluationManager.evaluateUnit(unit),
           let selectedEvaluation = evaluation.attributeEvaluationArray.first {
            EvaluationCalculationView(evaluation: evaluation, unitName: unit.modelName, selectedAttributeEvaluation: selectedEvaluation, isActive: $isActive)
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
                Divider()
                    .padding()
                Spacer()
                // FIXME: - Format
                let formatter = SpecificPurchaseUnitFormatter(unit: unit, unformattedString: "evaluation_unit_confirmation_message")
                Label(formatter.formattedString)
                    .padding()

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
