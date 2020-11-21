//
//  PurchaseCategorySelectionViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 20/11/2020.
//

import SystemKit

class PurchaseCategorySelectionViewModel: ObservableObject, ErrorPublisher {
    
    
    // MARK: - Categories
    lazy var purchaseCategories: [PurchaseCategory]? = {
        do {
            return try JSONDecoder.decodeLocalJSON(file: "PurchaseCategories", type: [PurchaseCategory].self)
        }
        catch let error {
            publishErrorMessage(error)
            return nil
        }
    }()
    
    lazy var purchaseItems: [PurchaseItem]? = {
        do {
            return try JSONDecoder.decodeLocalJSON(file: "PurchaseItems", type: [PurchaseItem].self)
        }
        catch let error {
            publishErrorMessage(error)
            return nil
        }
    }()
    
    func itemsForCategory(_ category: PurchaseCategory) -> [PurchaseItem]? {
        purchaseItems?.filter { category.purchaseItemIDs.contains($0.uuid) }
    }
    
    // MARK: - Errors
    var currentErrorMessage: String?
    
    // MARK: - Initialisation
    init() {
        _ = purchaseCategories
    }
    
}
