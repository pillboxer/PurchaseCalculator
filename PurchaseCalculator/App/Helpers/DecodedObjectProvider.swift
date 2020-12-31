//
//  JSONProvider.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import PurchaseCalculatorDataKit

class DecodedObjectProvider {
    
    static func attributes(sorted: Bool = false) -> [PurchaseAttribute]? {
        let attributes = provide(.attributes, type: [String:PurchaseAttribute].self)?.map { $0.value }
        if sorted {
            return attributes?.sorted { $0.handle < $1.handle }
        }
        return attributes
    }
    
    static var multiplierGroups: [PurchaseAttributeMultiplierGroup]? {
        provide(.attributeMultiplierGroups, type: [PurchaseAttributeMultiplierGroup].self)
    }
    
    static var purchaseItemGroups: [PurchaseItemGroup]? {
        provide(.itemGroup, type: [PurchaseItemGroup].self)
    }
    
    static var purchaseItems: [PurchaseItem]? {
        provide(.purchaseItems, type: [String:PurchaseItem].self)?.map { $0.value }
    }
    
    static var specificPurchaseUnitGroups: [SpecificPurchaseUnitGroup]? {
        provide(.specificPurchaseUnitGroups, type: [String: SpecificPurchaseUnitGroup].self)?.map { $0.value }
    }
    
    static var specificPurchaseUnits: [SpecificPurchaseUnit]? {
        provide(.specificPurchaseUnits, type: [String: SpecificPurchaseUnit].self)?.map { $0.value }
    }
    
    static var purchaseBrands: [PurchaseBrand]? {
        provide(.purchaseBrands, type: [String: PurchaseBrand].self)?.map { $0.value }
    }
    
    static var purchaseCategories: [PurchaseCategory]? {
        provide(.categories, type: [PurchaseCategory].self)
    }
    
    private static func provide<D: Decodable>(_ object: PurchaseCalculatorDatabaseChildType, type: D.Type) -> D? {
        // FIXME: - Keeping for debugging but remove bang
        try! JSONDecoder.decodeLocalJSON(file: object.rawValue, type: type)
    }
    
    
}
