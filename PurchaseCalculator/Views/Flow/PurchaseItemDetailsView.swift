//
//  PurchaseItemDetailsView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI

struct PurchaseItemDetailsView: View {
    
    @EnvironmentObject var model: PurchaseEvaluationViewModel
    @ObservedObject var evaluationManager: EvaluationManager
    @Environment(\.presentationMode) var presentationMode
    var item: PurchaseItem
    
    var body: some View {
        if let result = evaluationManager.evaluationResult {
            Text(result.resultMessage)
                .foregroundColor(result.textColor)
            Button("Reset") {
//                model.navigationIsActive = false
//                presentationMode.wrappedValue.dismiss()
            }
        }
        else {
            PurchaseItemFormView()
            Button("Calculate") {
                evaluationManager.evaluate(item, costing: model.potentialPurchaseCost)
            }
            Spacer()
        }
    }
}

struct PurchaseItemFormView: View {
    
    @EnvironmentObject var model: PurchaseEvaluationViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Enter in a few more details for your result")
                    .font(.system(size: 12, weight: .bold))
                .padding(.bottom)
                Spacer()
            }
            TextFieldWithLimitView(placeholder: "Brand Name (eg Apple)",
                                   textFieldText: $model.potentialPurchaseBrand,
                                   minimumCharacters: 3)
                .padding()
            Divider()
            TextFieldWithLimitView(placeholder: "Model Name (eg iPhone)",
                                   textFieldText: $model.potentialPurchaseModel,
                                   minimumCharacters: 3)
                .padding()
            Divider()
            TextFieldWithLimitView(placeholder: "Cost",
                                   textFieldText: $model.potentialPurchaseCostDisplayInfo,
                                   minimumCharacters: 2,
                                   keyboardType: .numberPad)
                .keyboardType(.decimalPad)
                .padding()
        }
        .padding()
    }
}
