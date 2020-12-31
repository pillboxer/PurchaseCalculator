//
//  UserPreferencesForm.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/12/2020.
//

import SwiftUI

struct UserPreferencesForm: View {
    
    @EnvironmentObject var model: UserPreferencesViewModel
    
    var attributes: [PurchaseAttribute]
    
    var body: some View {
        VStack {
            Label(model.listHeaderString)
                .padding(.bottom)
            ScrollView {
                ForEach(attributes, id: \.uuid) { attribute in
                    PurchaseAttributeWeightingSelectionView(initialValue: model.weightForValue(id: attribute.uuid).to(decimalPlaces: 2), attribute: attribute)
                        .padding([.leading, .trailing])
                }
            }
        }
    }
}
