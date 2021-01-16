//
//  EvaluationHistoryView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 16/01/2021.
//

import SwiftUI
import SystemKit

struct EvaluationHistoryView: View {
    
    @State private var isActive = false
    @State private var barAnimationComplete = true
    @State private var selectedEvaluation: Evaluation?
    
    var evaluations: [Evaluation] {
        Evaluation.allInstances
    }
    
    @ViewBuilder
    var destination: some View {
        if let evaluation = selectedEvaluation,
           let attribute = evaluation.attributeEvaluationArray.first {
            EvaluationCalculationView(
                barAnimationComplete: $barAnimationComplete,
                evaluation: evaluation,
                selectedAttributeEvaluation: attribute,
                isActive: $isActive,
                presentedFromHistory: true)
        }
    }
    
    var body: some View {
        BasicNavigationView {
            HiddenNavigationLink(destination: destination, isActive: $isActive)
            ListContainerView(headerText: "History") {
                VStack(spacing: 8) {
                    ForEach(evaluations) { evaluation in
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Label(evaluation.dateCreated.dateString(.medium), underlined: true)
                                Label(evaluation.unitName)
                                Label(evaluation.result.description)
                            }
                            Spacer()
                            BorderedButtonView(text: "View", width: 80, height: 25) {
                                selectedEvaluation = evaluation
                                isActive = true
                            }
                        }
                        .padding()
                        Divider()
                            .padding(.horizontal)
                    }
                    Spacer()
                }
            }

        }

    }
}
