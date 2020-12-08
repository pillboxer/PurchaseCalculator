//
//  PurchaseItemDetailsView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI

struct PurchaseItemDetailsView: View {
    
    @ObservedObject var evaluationManager: EvaluationManager
    @ObservedObject var model = PurchaseItemViewModel()
    
    var item: PurchaseItem
    
    var body: some View {
        if let result = evaluationManager.evaluationResult,
           let percentage = evaluationManager.regretLikelihoodPercentage {
            Text(result.resultMessage)
                .foregroundColor(result.textColor)
            Text("Your likelihood of regretting this purchase is \(percentage)")
            Button("Reset") {
//                model.navigationIsActive = false
//                presentationMode.wrappedValue.dismiss()
            }
        }
        else {
            PurchaseItemFormView(model: model)
            Button("Calculate") {
                evaluationManager.evaluate(item, costing: model.cost)
            }
            Spacer()
        }
    }
}

struct PurchaseItemFormView: View {
    
    @ObservedObject var model: PurchaseItemViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Enter in a few more details for your result")
                    .font(.system(size: 12, weight: .bold))
                .padding(.bottom)
                Spacer()
            }
            TextFieldWithLimitView(placeholder: "Brand Name (eg Apple)",
                                   textFieldText: $model.brandName,
                                   minimumCharacters: 3)
                .padding()
            Divider()
            TextFieldWithLimitView(placeholder: "Model Name (eg iPhone)",
                                   textFieldText: $model.modelName,
                                   minimumCharacters: 3)
                .padding()
            Divider()
            TextFieldWithLimitView(placeholder: "Cost",
                                   textFieldText: $model.costString,
                                   minimumCharacters: 2,
                                   keyboardType: .numberPad)
                .keyboardType(.decimalPad)
                .padding()
        }
        .padding()
    }
}
