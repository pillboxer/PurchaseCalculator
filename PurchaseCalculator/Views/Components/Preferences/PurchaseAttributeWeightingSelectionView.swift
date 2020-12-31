//
//  PurchaseAttributeWeightingSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/12/2020.
//

import SwiftUI

struct PurchaseAttributeWeightingSelectionView: View {
    @EnvironmentObject var model: UserPreferencesViewModel
    @State var initialValue: Double
    var attribute: PurchaseAttribute
    
    var image: some View {
        Image(attribute.symbol)
            .resizable()
            .frame(width: 20, height: 20)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                image
                Label(attribute.handle)
            }
            HStack {
                let weighting = AttributeUserWeighting(weight: initialValue)
                StepperWithFillingRectangles(numberOfRectangles: 5, cornerRadiusForRectangles: 2, valueToChange: $initialValue, userWeighting: weighting) { newValue in
                    initialValue = newValue.to(decimalPlaces: 2)
                    model.addAttributeValue(id: attribute.uuid, weight: newValue)
                }
            }
        }
    }
}


