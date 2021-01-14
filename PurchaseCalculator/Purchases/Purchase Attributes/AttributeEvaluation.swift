//
//  AttributeEvaluation.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 28/12/2020.
//

import Foundation

extension AttributeEvaluation {
    
    var userWeighting: AttributeUserWeighting {
        AttributeUserWeighting(weight: userWeightingScore)
    }
    
    var attributeResult: AttributeResult {
        AttributeResult(score: attributeScore)
    }

}
