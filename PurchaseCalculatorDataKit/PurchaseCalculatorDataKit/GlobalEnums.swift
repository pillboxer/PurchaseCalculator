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
    
    case homescreenBlockContainers = "HomescreenBlockContainers"
    case homescreenBlocks = "HomescreenBlocks"
    
    case evaluationScreenBlockContainers = "EvaluationScreenBlockContainers"
    case evaluationScreenBlocks = "EvaluationScreenBlocks"
    
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
    case brand
    case imageName
    case units
    case specificPurchaseUnitGroup
    case key
    case value
    case evaluationCount
    case destination
    case isWide
    case position
    case isHidden
    
   public var childReference: PurchaseCalculatorDatabaseChildType? {
        switch self {
        case .brand:
        return .purchaseBrands
        default:
            return nil
        }
    }
    
    public var isList: Bool {
        switch self {
        case .units:
            return true
        default:
            return false
        }
    }
    
}


public enum BlockDestination: String {
    case userPreferences
    case popular
    case displayPreferences
    case evaluation
    case history
    case error
    case brands
    
    public var isModal: Bool {
        switch self {
        case .evaluation, .popular, .history, .brands:
            return false
        default:
            return true
        }
    }
}
