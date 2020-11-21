//
//  PurchaseItemDetailsView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI

struct PurchaseItemDetailsView: View {
    
    @EnvironmentObject var model: PurchaseCategorySelectionViewModel
    
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
                                   minimumCharacters: 3,
                                   maximumCharacters: 10)
                .padding()
            Divider()
            TextFieldWithLimitView(placeholder: "Model Name (eg iPhone)",
                                   textFieldText: $model.potentialPurchaseModel,
                                   minimumCharacters: 3,
                                   maximumCharacters: 10)
                .padding()
            Divider()
            TextFieldWithLimitView(placeholder: "Cost",
                                   textFieldText: $model.potentialPurchaseCostDisplayInfo,
                                   minimumCharacters: 2,
                                   maximumCharacters: 10)
                .keyboardType(.decimalPad)
                .padding()
            Spacer()

        }
        .padding()
    }
}
