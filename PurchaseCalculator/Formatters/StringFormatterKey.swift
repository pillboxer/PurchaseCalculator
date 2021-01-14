//
//  StringFormatterKey.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 07/01/2021.
//

import Foundation

enum StringFormatterKey: String, CaseIterable {
    
    // MARK: - Multiple Formatters
    case cost = "{cost}"
    
    // MARK: - EvaluationStringFormatter
    case purchaseItemName = "{purchase_item_name}"
    case attributeDescription = "{attribute_evaluation_result_description}"
    case attributeDescriptionWithArticle = "{attribute_evaluation_result_description_with_article}"
    case attributeName = "{attribute_name}"
    
    // MARK: - PurchaseAttributeEvaluationFormatter
    case purchaseAttributesCount = "{purchase_attributes_count}"
    
    // MARK: - SpecificPurchaseUnitFormatter
    case brandHandle = "{brand_handle}"
    case modelName = "{model_name}"
}
