//
//  CustomUnitCreationViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 01/02/2021.
//

import Foundation
import SwiftUI

class CustomUnitCreationViewModel: ObservableObject {
    
    @Published var brandName: String = ""
    @Published var modelName: String = ""
    
    var costString = "" {
        didSet {
            guard !costString.isEmpty else {
                objectWillChange.send()
                return
            }
            let currency = User.existingUser?.selectedCurrency ?? .GBP
            let index = costString.firstIndex(of: Character(currency.symbol))
            costString.safeRemove(at: index)
            costString.insert(Character(currency.symbol), at: costString.startIndex)
            if Double(costString.dropFirst()) == nil {
                costString = String(currency.symbol)
            }
            objectWillChange.send()
        }
    }
    
    var cost: Double {
        Double(costString.dropFirst()) ?? 0
    }
    
    var buttonIsDisabled: Bool {
        brandName.isEmpty || modelName.isEmpty || cost.isZero
    }
    
    
}

