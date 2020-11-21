//
//  PurchaseCategorySelectionViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 20/11/2020.
//

import SystemKit

class PurchaseCategorySelectionViewModel: ObservableObject, ErrorPublisher {
    
    // MARK: - Properties (Public)
    lazy var purchaseCategories: [PurchaseCategory]? = {
        do {
            return try JSONDecoder.decodeLocalJSON(file: "PurchaseCategories", type: [PurchaseCategory].self)
        }
        catch let error {
            publishErrorMessage(error)
            return nil
        }
    }()
    
    // MARK: - Errors
    var currentErrorMessage: String?
    
    // MARK: - Initialisation
    init() {
        _ = purchaseCategories
    }
    
}
