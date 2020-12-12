//
//  GlobalEnums.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 15/11/2020.
//

import Foundation

// MARK: - Currency
enum Currency: String, CaseIterable {
    
    case GBP
    case USD
    
    var symbol: String {
        switch self {
        case .GBP:
            return "£"
        case .USD:
            return "$"
        }
    }
    
   static func currencyForSymbol(_ symbol: String) -> Currency {
        Currency.allCases.filter { $0.symbol == symbol }.first ?? .GBP
    }
    
}

enum PurchaseCalculatorJSONFileType: String, CaseIterable {
    case categories = "PurchaseCategories"
    case itemGroup = "PurchaseItemGroups"
    case items = "PurchaseItems"
    case specificUnits = "SpecificPurchaseUnits"
    case specificUnitGroups = "SpecificPurchaseUnitGroups"
    case brands = "PurchaseBrands"
    case attributes = "PurchaseAttributes"
    case attributeMultiplierGroups = "PurchaseItemAttributeMultipliersGroups"
    case valuesQuestions = "PurchaseAttributeValueQuestions"
}
