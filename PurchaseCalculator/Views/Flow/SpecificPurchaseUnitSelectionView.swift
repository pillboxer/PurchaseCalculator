//
//  SpecificPurchaseUnitSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 12/12/2020.
//

import SwiftUI
import PurchaseCalculatorDataKit

struct SpecificPurchaseUnitSelectionView: View {
    
    var selectionColor: Color {
        Color(.sRGB, red: 0, green: 0.7, blue: 0.5, opacity: 0.7)
    }
    
    @StateObject var viewModel: SpecificPurchaseUnitSelectionViewModel
    
    var body: some View {
        BasicNavigationView {
            ListContainerView(headerText: "Select your model",
                              list: SpecicPurchaseUnitListView(viewModel: viewModel))
        }
    }
}

private struct SpecicPurchaseUnitListView: View {
    
    @ObservedObject var viewModel: SpecificPurchaseUnitSelectionViewModel
    @State private var selection: String?
    @State private var evaluation: EvaluationManager.Evaluation?
    
    private func expandedContentFor(unit: SpecificPurchaseUnit) -> some View {
        VStack {
            let evaluationManager = viewModel.evaluationManager
            let evaluation = evaluationManager.evaluateUnit(unit)
            ExpandedRow(leadingText: "Cost", trailingText: PriceFormatter.format(cost: unit.cost))
            let destination = EvaluationCalculationView(evaluation: evaluation,
                                                        unitName: unit.modelName,
                                                        selectedAttributeEvaluation: evaluation.attributeEvaluations.first!)
                            .navigationBarHidden(true)
            NavigationLink(destination: destination, tag: unit.id, selection: $selection) {
                BorderedButtonView(text: "Evaluate") {
                    selection = unit.id
                }
                .frame(width: 70, height: 30)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.units) { unit in
                    ExpandableRowView(isExpanded: viewModel.isExpanded(unit),
                                      title: unit.modelName,
                                      expandedContent: expandedContentFor(unit: unit)) { expanded in
                        handleExpansion(expanded, for: unit)
                    }
                }
            }
        }
    }
    
    private func handleExpansion(_ shouldExpand: Bool, for unit: SpecificPurchaseUnit) {
        viewModel.selectUnit(unit)
    }
    
}

private struct ExpandedRow: View {
    
    var leadingText: String
    var trailingText: String
    
    var body: some View {
        HStack {
            PCTextView(leadingText)
            Spacer()
            PCTextView(trailingText)
        }
        .padding(.bottom)
    }
    
}
