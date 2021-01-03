//
//  EvaluationCalculationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 24/12/2020.
//

import SwiftUI

struct EvaluationCalculationView: View {
    
    // MARK: - Private
    @State private var barAnimationComplete = false
    @State private var opacity: Double = 0
    
    var evaluation: EvaluationManager.Evaluation
    var unitName: String
    @State var selectedAttributeEvaluation: AttributeEvaluation
    
    var body: some View {
        VStack {
            Label(unitName)
                .padding(.top, 16)
            PurchaseAttributesDualGraphView(attributeEvaluations: evaluation.attributeEvaluations,
                                            selectedEvaluation: $selectedAttributeEvaluation,
                                            animationComplete: $barAnimationComplete)
            Divider()
        }
        VStack {
            PurchaseAttributeSummaryView(selectedEvaluation: selectedAttributeEvaluation,
                                         itemName: evaluation.itemName)
            Divider()
            EvaluationReportView(evaluation: evaluation)
                .padding(.horizontal)
            SaveEvaluationView()
        }
        .navigationBarHidden(true)
        .opacity(opacity)
        .onChange(of: barAnimationComplete) { _ in
            withAnimation(.easeIn(duration: 1)) { opacity = 1}
        }
    }
    
}
