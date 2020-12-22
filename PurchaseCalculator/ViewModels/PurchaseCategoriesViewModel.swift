//
//  PurchaseCategorySelectionViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 20/11/2020.
//

import SystemKit

class PurchaseCategoriesViewModel: ObservableObject, ErrorPublisher {
    
    // MARK: - Exposed Stored
    var currentErrorMessage: String?
    
    var purchaseCategories: [PurchaseCategory]? {
        do {
            return try JSONDecoder.decodeLocalJSON(file: "PurchaseCategories", type: [PurchaseCategory].self)
        }
        catch let error {
            publishErrorMessage(error)
            return nil
        }
    }
    
    // MARK: - Exposed Functions
    func itemsForCategory(_ category: PurchaseCategory) -> [PurchaseItem]? {
        category.purchaseItemGroup?.items?.sorted { $0.handle < $1.handle }
    }
}

// MARK: - String Provider
extension PurchaseCategoriesViewModel {
    
    var listHeaderTitle: String {
        "What type of purchase do you want to evaluate today?"
    }

}
