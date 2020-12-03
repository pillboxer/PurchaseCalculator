//
//  PurchaseItemsViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/12/2020.
//

import Combine

class PurchaseItemViewModel: ObservableObject {
    
    @Published var brandName = ""
    @Published var modelName = ""
    
    
    // MARK: - Exposed
    var costString = "" {
        didSet {
            guard !costString.isEmpty else {
                // We allow the symbol to be deleted so the placeholder text can be read
                return
            }
            // Get the symbol index and remove the symbol
            let index = costString.firstIndex(of: symbolCharacter)
            costString.safeRemove(at: index)
            // Look at the cost and make sure it is within the max
            let clipped = costString.prefix(maximumDigitsForCost)
            costString = String(clipped)
            // Re add the symbol
            costString.insert(symbolCharacter, at: costString.startIndex)
            objectWillChange.send()
        }
    }
    
    var cost: Double {
        Double(costString.dropFirst()) ?? 0
    }
    
    // MARK: - Private
    let maximumDigitsForCost = 10
    
    private lazy var symbol: String = {
         User.existingUser?.selectedCurrency.symbol ?? "£"
    }()
    
    private var symbolCharacter: Character {
        Character(symbol)
    }
    
}

extension String {
    
    mutating func safeRemove(at index: String.Index?) {
        if let index = index {
            remove(at: index)
        }
    }

}
