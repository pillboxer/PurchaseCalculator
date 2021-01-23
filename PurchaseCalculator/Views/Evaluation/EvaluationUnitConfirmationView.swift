//
//  EvaluationUnitConfirmationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/01/2021.
//

import SwiftUI
import PurchaseCalculatorDataKit

struct EvaluationUnitConfirmationView: View {
    
    let unit: SpecificPurchaseUnit
    let item: PurchaseItem
    let evaluationManager: EvaluationManager
    @State private var buttonPressed = false
    @State private var barAnimationComplete = false
    @Binding var isActive: Bool
    
    init(unit: SpecificPurchaseUnit, item: PurchaseItem, isActive: Binding<Bool>) {
        self.unit = unit
        self.item = item
        self.evaluationManager = EvaluationManager(item: item)
        self._isActive = isActive
    }
    
    @ViewBuilder
    var destination: some View {
        if let evaluation = evaluationManager.evaluateUnit(unit),
           let selectedEvaluation = evaluation.attributeEvaluationArray.first {
            EvaluationCalculationView(barAnimationComplete:$barAnimationComplete, evaluation: evaluation, selectedAttributeEvaluation: selectedEvaluation, isActive: $isActive)
        }
        
    }
    
    var body: some View {
        EmptorColorSchemeAdaptingView {
            HiddenNavigationLink(destination: destination, isActive: $buttonPressed)
            VStack(spacing: 8) {
                ReportTitleView(text: "confirmation_report_title")
                    .padding()
                ReportRowView(title: "confirmation_report_row_0", value: item.handle, imageWrapper: ImageWrapper(name: item.imageName))
                ReportRowView(title: "confirmation_report_row_1", value: unit.modelName, imageWrapper: ImageWrapper(name: unit.imageName, renderingMode: .template))
                ReportRowView(title: "confirmation_report_row_2", value: PriceFormatter.format(cost: unit.cost), imageWrapper: ImageWrapper(name: "confirmation_report_row_2_image"))
                if let evaluationCount = unit.evaluationCount,
                   evaluationCount > 0 {
                    ReportRowView(title: "confirmation_report_row_3", value: String(evaluationCount),imageWrapper: ImageWrapper(name: "confirmation_report_row_3_image"))
                }
                Divider()
                    .padding()
                Spacer()
                let formatter = SpecificPurchaseUnitFormatter(unit: unit, unformattedString: "evaluation_unit_confirmation_message")
                Label(formatter.formattedString)
                    .padding()
                Spacer()
                HStack(spacing: 32) {
                    DismissalButton()
                    CTAButton(text: "evaluate_cta") {
                        CloudKitCoordinator.shared.updateEvaluationCountFor(uuid: unit.uuid)
                        buttonPressed = true
                    }
                }

            }
            .padding()
        }

    }
    
}
