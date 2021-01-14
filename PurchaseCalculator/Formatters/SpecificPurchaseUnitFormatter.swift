//
//  SpecificPurchaseUnitFormatter.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 14/01/2021.
//

import Foundation

struct SpecificPurchaseUnitFormatter: StringFormatter {
    
    let unit: SpecificPurchaseUnit
    
    var unformattedString: String
    
    var requiredKeys: [StringFormatterKey] {
        [.modelName, .brandHandle, .cost]
    }
    
    func replace(_ string: String, for key: StringFormatterKey) -> String {
        switch key {
        case .modelName:
            return string.replacingOccurrences(of: key, with: unit.modelName)
        case .brandHandle:
            return string.replacingOccurrences(of: key, with: unit.brandHandle)
        case .cost:
            let cost = PriceFormatter.format(cost: unit.cost)
            return string.replacingOccurrences(of: .cost, with: cost)
        default:
            return string
        }
    }
    
}
