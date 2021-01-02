//
//  JSONProvider.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import PurchaseCalculatorDataKit

class DecodedObjectProvider {
    
    static func attributes(sorted: Bool = false) -> [PurchaseAttribute]? {
        let attributes = provide(.attributes, type: [PurchaseAttribute].self)
        if sorted {
            return attributes?.sorted { $0.handle < $1.handle }
        }
        return attributes
    }
    
    static var multiplierGroups: [PurchaseAttributeMultiplierGroup]? {
        provide(.attributeMultiplierGroups, type: [PurchaseAttributeMultiplierGroup].self)
    }
    
    static var purchaseItemGroups: [PurchaseItemGroup]? {
        provide(.purchaseItemGroups, type: [PurchaseItemGroup].self)
    }
    
    static var purchaseItems: [PurchaseItem]? {
        provide(.purchaseItems, type: [PurchaseItem].self)
    }
    
    static var specificPurchaseUnitGroups: [SpecificPurchaseUnitGroup]? {
        provide(.specificPurchaseUnitGroups, type: [SpecificPurchaseUnitGroup].self)
    }
    
    static var specificPurchaseUnits: [SpecificPurchaseUnit]? {
        provide(.specificPurchaseUnits, type: [SpecificPurchaseUnit].self)
    }
    
    static var purchaseBrands: [PurchaseBrand]? {
        provide(.purchaseBrands, type: [PurchaseBrand].self)
    }
    
    static var purchaseCategories: [PurchaseCategory]? {
        provide(.categories, type: [PurchaseCategory].self)
    }
    
    static var homescreenBlocks: [HomescreenBlock]? {
        print("sending blocks")
        return provide(.homescreenBlocks, type: [HomescreenBlock].self)
    }
    
    private static func provide<D: Decodable>(_ object: PurchaseCalculatorDatabaseChildType, type: D.Type) -> D? {
        // FIXME: - Keeping for debugging but remove bang
        try! JSONDecoder.decodeLocalJSON(file: object.rawValue, type: type)
    }
}
