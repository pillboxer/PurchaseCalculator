//
//  SpecificPurchaseUnitSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 12/12/2020.
//

import SwiftUI

struct SpecificPurchaseUnitSelectionView: View {
    
    var units: [SpecificPurchaseUnit]
    
    var body: some View {
        List(units) {
            Text($0.modelName)
        }
    }
}
