//
//  JSONProvider.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import PurchaseCalculatorDataKit

class DecodedObjectProvider {
    
    static var attributes: [PurchaseAttribute]? {
        provide(.attributes, type: [PurchaseAttribute].self)
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
        try! JSONDecoder.decodeLocalJSON(file: object.rawValue, type: type)
    }
    
    
}
