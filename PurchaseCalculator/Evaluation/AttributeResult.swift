//
//  AttributeResult.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 28/12/2020.
//

import Foundation

enum AttributeResult: ColorProvider, Equatable {
    
    case veryPoor(Double)
    case poor(Double)
    case average(Double)
    case good(Double)
    case veryGood(Double)
    
    private var rawValue: String {
        let beforeParen = String(describing: self).components(separatedBy: "(").first ?? ""
        return beforeParen.snakeCased()
    }
    
    private var rawDescription: String {
        rawValue + "_attribute_result_description"
    }
    
    var description: String {
        String.forKey(rawDescription)
    }
    
    var colorScore: Double {
        switch self {
        case .average(let score), .good(let score), .poor(let score), .veryGood(let score), .veryPoor(let score):
            return score / 2
        }
    }
    
    var descriptionWithArticle: String {
        let article = String.forKey("\(rawDescription)_article")
        return "\(article) \(description)"
    }
    
    static func resultFor(_ score: Double) -> AttributeResult {
        let result: AttributeResult
        
        if score <= 0.5 {
            result = .veryPoor(score)
        }
        else if score <= 0.75 {
            result = .poor(score)
        }
        else if score <= 1 {
            result = .average(score)
        }
        else if score <= 1.5 {
            result = .good(score)
        }
        else {
            result = .veryGood(score)
        }
        return result
    }
    
    init(score: Double) {
        self = AttributeResult.resultFor(score)
    }
}
