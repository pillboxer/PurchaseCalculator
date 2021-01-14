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
    @Binding var isActive: Bool
    
    @ViewBuilder
    var destination: some View {
        if let selectedUnit = selectedUnit,
        let item = selectedUnit.item {
            EvaluationUnitConfirmationView(unit: selectedUnit, item: item, isActive: $isActive)
        }
        else {
            Text("Something went wrong")
        }
    }
    
    var body: some View {
        BasicNavigationView {
            ListContainerView(headerText: "unit_selection_header") {
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


