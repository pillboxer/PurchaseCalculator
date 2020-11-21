//
//  PurchaseCategorySelectionViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 20/11/2020.
//

import SystemKit

class PurchaseCategorySelectionViewModel: ObservableObject, ErrorPublisher {
    
    // MARK: - Private Stored
    private var potentialPurchaseCost: Double = 0
    
    // MARK: - Exposed Stored
    var currentErrorMessage: String?

    // MARK: - Published
    @Published var potentialPurchaseBrand = ""
    @Published var potentialPurchaseModel = ""
    var potentialPurchaseCostDisplayInfo = "" {
        didSet {
            if !potentialPurchaseCostDisplayInfo.contains(symbol) {
                self.potentialPurchaseCostDisplayInfo = symbol + potentialPurchaseCostDisplayInfo
            }
            potentialPurchaseCost = Double(potentialPurchaseCostDisplayInfo.dropFirst()) ?? 0
            objectWillChange.send()
        }
    }
    
    // MARK: - Lazy
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
    
    private lazy var symbol: String = {
         User.existingUser?.selectedCurrency.symbol ?? "£"
    }()
    
    // MARK: - Exposed Functions
    func itemsForCategory(_ category: PurchaseCategory) -> [PurchaseItem]? {
        purchaseItems?.filter { category.purchaseItemIDs.contains($0.uuid) }
    }

}
