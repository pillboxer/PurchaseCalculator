//
//  GlobalEnums.swift
//  PurchaseCalculatorDataKit
//
//  Created by Henry Cooper on 17/12/2020.
//

import Foundation

public enum PurchaseCalculatorDatabaseChildType: String, CaseIterable, Identifiable {
    case categories = "PurchaseCategories"
    case itemGroup = "PurchaseItemGroups"
    case purchaseItems = "PurchaseItems"
    
    case specificPurchaseUnits = "SpecificPurchaseUnits"
    case specificPurchaseUnitGroups = "SpecificPurchaseUnitGroups"
    
    case purchaseBrands = "PurchaseBrands"
    
    case attributes = "PurchaseAttributes"
    case attributeMultiplierGroups = "PurchaseItemAttributeMultipliersGroups"
    
    case strings = "Strings"
    
    var singular: String {
        String(rawValue.dropLast())
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
