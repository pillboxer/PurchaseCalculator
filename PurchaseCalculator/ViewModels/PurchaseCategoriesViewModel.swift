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
        DecodedObjectProvider.purchaseCategories
    }
    
    // MARK: - Exposed private functions
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
