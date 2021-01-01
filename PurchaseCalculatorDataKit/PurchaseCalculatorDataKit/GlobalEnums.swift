//
//  GlobalEnums.swift
//  PurchaseCalculatorDataKit
//
//  Created by Henry Cooper on 17/12/2020.
//

import Foundation

public enum PurchaseCalculatorDatabaseChildType: String, CaseIterable, Identifiable {
    case categories = "PurchaseCategories"
    case purchaseItemGroups = "PurchaseItemGroups"
    case purchaseItems = "PurchaseItems"
    
    case specificPurchaseUnits = "SpecificPurchaseUnits"
    case specificPurchaseUnitGroups = "SpecificPurchaseUnitGroups"
    
    case purchaseBrands = "PurchaseBrands"
    
    case attributes = "PurchaseAttributes"
    case attributeMultiplierGroups = "PurchaseAttributeMultiplierGroups"
    
    case strings = "Strings"
    
    var cloudKitType: String {
        switch self {
        case .attributeMultiplierGroups:
            return "PurchaseAttributeMultipliers"
        default: return rawValue
        }
    }
    
    public var id: String {
        rawValue
    }
}

public enum PurchaseCalculatorDatabaseValueType: String {
    case cost
    case handle
    case uuid
    case modelName
    case brandID
    case imageName
    case unitIDs
    case specificPurchaseUnitGroupID
}
