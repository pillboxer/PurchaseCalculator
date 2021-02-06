//
//  EvaluationCalculationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 24/12/2020.
//

import SwiftUI

struct EvaluationCalculationView: View {
    
    // MARK: - Private
    @Binding var barAnimationComplete: Bool
    @State private var opacity: Double = 0

    var evaluation: Evaluation
    @State var selectedAttributeEvaluation: AttributeEvaluation
    @Binding var isActive: Bool
    var presentedFromHistory: Bool = false
    
    var body: some View {
        EmptorColorSchemeAdaptingView {
            VStack {
                VStack {
                    Label(evaluation.unitName)
                        .padding(.top, 16)
                    PurchaseAttributesDualGraphView(attributeEvaluations: evaluation.attributeEvaluationArray,
                                                    selectedEvaluation: $selectedAttributeEvaluation,
                                                    animationComplete: $barAnimationComplete)
                    Divider()
                }
                VStack {
                    PurchaseAttributeSummaryView(selectedEvaluation: selectedAttributeEvaluation,
                                                 itemName: evaluation.itemName)
                    Divider()
                    EvaluationReportView(evaluation: evaluation)
                    if presentedFromHistory {
                        DismissalButton()
                            .padding()
                    } else {
                        CTAButton(text: "save_cta") {
                            CoreDataManager.shared.save(evaluation.managedObjectContext)
                            isActive = false
                        }
                        .padding()
                    }
                }
                .onAppear {
                    // If we're coming from History
                    if barAnimationComplete {
                        opacity = 1
                    }
                }
                .opacity(opacity)
                .onChange(of: barAnimationComplete) { _ in
                    withAnimation(.easeIn(duration: 1)) { opacity = 1 }
                }
            }
            .padding(.horizontal)
        }
    }
}
