//
//  SpecificPurchaseUnitSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 12/12/2020.
//

import SwiftUI

struct SpecificPurchaseUnitSelectionView: View {
    
    var units: [SpecificPurchaseUnit]
    
    func expandedContentFor(unit: SpecificPurchaseUnit) -> some View {
        HStack {
            Text("Cost")
            Spacer()
            Text(String(unit.cost))
        }
    }
    
    var body: some View {
        BasicNavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(units) { unit in
                        ExpandableRowView(title: unit.modelName, expandedContent: expandedContentFor(unit: unit))
                    }
                }
                
            }
        }
    }
}
