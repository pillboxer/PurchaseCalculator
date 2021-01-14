//
//  EvaluationStringFormatter.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 04/01/2021.
//

import Foundation

struct AttributeEvaluationStringFormatter: StringFormatter {
    
    let evaluation: AttributeEvaluation
    let itemName: String
    let unformattedString: String
    
    var requiredKeys: [StringFormatterKey] {
        [.purchaseItemName, .attributeDescriptionWithArticle, .attributeDescription, .attributeName]
    }
    
    func replace(_ string: String, for key: StringFormatterKey) -> String {
        switch key {
        case .purchaseItemName:
            return string.replacingOccurrences(of: key, with: itemName)
        case .attributeDescription:
            return string.replacingOccurrences(of: key, with: evaluation.attributeResult.description)
        case .attributeDescriptionWithArticle:
            return string.replacingOccurrences(of: key, with: evaluation.attributeResult.descriptionWithArticle)
        case .attributeName:
            return string.replacingOccurrences(of: key, with: evaluation.attributeName)
        default:
            return string
        }
    }
    
}
