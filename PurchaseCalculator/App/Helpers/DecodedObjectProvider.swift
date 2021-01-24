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
    
    static var allSpecificPurchaseUnits: [SpecificPurchaseUnit]? {
        // Careful. This will get all units regardless of whether they have an item or not. Most callers should check the item is nil or not
        provide(.specificPurchaseUnits, type: [SpecificPurchaseUnit].self)
    }
    
    static func popularSpecificPurchaseUnits(limit: Int) -> [SpecificPurchaseUnit]? {
        return Array(allSpecificPurchaseUnits?.sorted { $0.evaluationCount ?? 0 > $1.evaluationCount ?? 0 }.prefix(limit) ?? []).filter { $0.item != nil }
    }
    
    static var purchaseBrands: [PurchaseBrand]? {
        provide(.purchaseBrands, type: [PurchaseBrand].self)
    }
    
    static var purchaseCategories: [PurchaseCategory]? {
        provide(.categories, type: [PurchaseCategory].self)
    }
    
    static var homescreenBlockContainers: [BlockContainer]? {
        let unhidden = provide(.homescreenBlockContainers, type: [BlockContainer].self)?.filter { $0.isHidden == false }
        return unhidden?.sorted { $0.position < $1.position }
    }
    
    static var evaluationScreenBlockContainers: [BlockContainer]? {
        provide(.evaluationScreenBlockContainers, type: [BlockContainer].self)?.filter { $0.isHidden == false }
    }
    
    static var homescreenBlocks: [ScreenBlock]? {
        provide(.homescreenBlocks, type: [ScreenBlock].self)?.filter { $0.isHidden == false }
    }
    
    static var evaluationScreenBlocks: [ScreenBlock]? {
        provide(.evaluationScreenBlocks, type: [ScreenBlock].self)?.filter { $0.isHidden == false }
    }
    
    private static func provide<D: Decodable>(_ object: PurchaseCalculatorDatabaseChildType, type: D.Type) -> D? {
        try? JSONDecoder.decodeLocalJSON(folder: "Emptor/JSON", file: object.rawValue, type: type)
    }
}
