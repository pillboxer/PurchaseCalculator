//
//  EvaluationResult.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 14/01/2021.
//

import Foundation

enum EvaluationResult: String, CaseIterable {
            
    case negative
    case neutralLow
    case neutralHigh
    case positive
    
    var threshold: Double {
        switch self {
        case .negative:
            return 0.25
        case .neutralLow:
            return 0.5
        case .neutralHigh:
            return 0.75
        case .positive:
            return 1
        }
    }
    
    var description: String {
        rawValue + "_evaluation_result"
    }
    
    init(score: Double) {
        for type in EvaluationResult.allCases {
            if score < type.threshold {
                self = type
                return
            }
        }
        self = .positive
    }
            
}
