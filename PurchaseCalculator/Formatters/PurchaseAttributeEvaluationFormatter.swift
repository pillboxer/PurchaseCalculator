//
//  PurchaseAttributeEvaluationFormatter.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 09/01/2021.
//

import Foundation

struct PurchaseAttributeStringFormatter: StringFormatter {
    
    let unformattedString: String
    
    var requiredKeys: [StringFormatterKey] {
        [.purchaseAttributesCount]
    }
    
    func replace(_ string: String, for key: StringFormatterKey) -> String {
        switch key {
        case .purchaseAttributesCount:
            return string.replacingOccurrences(of: key, with: DecodedObjectProvider.attributes()?.count)
        default:
            return string
        }
    }
    
}
