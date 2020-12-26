//
//  SpecificPurchaseUnitSelectionViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 23/12/2020.
//

import Foundation

class SpecificPurchaseUnitSelectionViewModel: ObservableObject {
    
    @Published var units: [SpecificPurchaseUnit] = []
    @Published var selectedUnit: SpecificPurchaseUnit?
    
    var evaluationManager: EvaluationManager
    
    init(units: [SpecificPurchaseUnit], item: PurchaseItem) {
        self.units = units.sorted { $0.modelName < $1.modelName }
        self.evaluationManager = EvaluationManager(item: item)
    }


    func isExpanded(_ unit: SpecificPurchaseUnit) -> Bool {
        selectedUnit == unit
    }
    
    func selectUnit(_ unit: SpecificPurchaseUnit) {
        if unit == selectedUnit {
            selectedUnit = nil
        }
        else {
            selectedUnit = unit
        }
    }
    
    func formattedCost(_ cost: Double) -> String {
        let currency = User.existingUser?.selectedCurrency ?? .GBP
        return PriceFormatter.format(cost: cost, currency: currency)
    }
    
}
