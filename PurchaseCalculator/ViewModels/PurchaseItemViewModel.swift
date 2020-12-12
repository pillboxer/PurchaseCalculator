//
//  PurchaseItemsViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/12/2020.
//

import Combine

class PurchaseItemViewModel: ObservableObject {
    
    var item: PurchaseItem
    
    init(item: PurchaseItem) {
        self.item = item
    }
    
    var brands: [PurchaseBrand] {
        item.brands.sorted { $0.name < $1.name }
    }
    
    func unitsForBrand(_ brand: PurchaseBrand) -> [SpecificPurchaseUnit] {
        // FIXME: - Optional
        item.specificPurchaseUnits?.filter { $0.brand == brand } ?? []
    }
    
}

extension String {
    
    mutating func safeRemove(at index: String.Index?) {
        if let index = index {
            remove(at: index)
        }
    }

}
