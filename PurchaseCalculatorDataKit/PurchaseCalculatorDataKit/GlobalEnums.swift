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
       
    case images = "Images"

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
    
    public var deleteSelfIfReferencesDeleted: Bool {
        switch self {
        case .homescreenBlockContainers, .evaluationScreenBlockContainers, .categories, .purchaseItemGroups, .specificPurchaseUnitGroups:
            return false
        case .attributeMultiplierGroups, .specificPurchaseUnits, .purchaseItems:
            return true
        default:
            return false
        }
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
    case multiplier
    case attributeMultiplierGroup
    case blocks

   public var childReference: PurchaseCalculatorDatabaseChildType? {
        switch self {
        case .brand:
        return .purchaseBrands
        case .attributeMultiplierGroup:
            return .attributeMultiplierGroups
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
    case items
    case addYourOwn
    
    public var isModal: Bool {
        switch self {
        case .displayPreferences, .userPreferences:
            return true
        default:
            return false
        }
    }
}
