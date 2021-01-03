//
//  EvaluationUnitSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/01/2021.
//

import SwiftUI

struct EvaluationUnitSelectionView: View {
    
    var units: [SpecificPurchaseUnit]?
    @State var selectedRow: String?
    @State var selectedUnit: SpecificPurchaseUnit?
    
    @ViewBuilder
    var destination: some View {
        if let selectedUnit = selectedUnit,
        let item = selectedUnit.item {
            EvaluationUnitConfirmationView(unit: selectedUnit, item: item)
        }
        else {
            Text("Something went wrong")
        }
    }
    
    var body: some View {
        BasicNavigationView {
            ListContainerView(headerText: "Choose your item") {
                ForEach(units ?? []) { unit in
                    NavigationLinkedRowView(item: unit, destinationController: destination, selectedID: $selectedRow) {
                        selectedRow = unit.uuid
                        selectedUnit = unit
                    }
                }
            }

        }
    }
    
}


