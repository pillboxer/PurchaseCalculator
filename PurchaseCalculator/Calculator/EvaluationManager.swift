//
//  EvaluationManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 22/11/2020.
//

import Foundation

class EvaluationManager: ObservableObject {
    
    @Published var error: EvaluationError?
    @Published var evaluationResult: EvaluationResult? {
        didSet {
            hasEvaluated = true
        }
    }
    var hasEvaluated = false
    
    enum EvaluationError: String {
        case couldNotEvaluate = "Could evaluate, please try again"
        
        var message: String {
            rawValue
        }
    }
    
    var thresholdEvaulationPairs: [(threshold: Double, result: EvaluationResult)] {
        [
            (0.5, EvaluationResult.negative("Definitely Not")),
            (0.6, .negative("Wait One Week")),
            (0.8, .negative("Sleep On It")),
            (1, .positive("Looks Like A Good Buy"))
        ]
    }
    
    enum EvaluationResult {
        case negative(String)
        case positive(String)
    }
    
    static let shared = EvaluationManager()
    
    func evaluate(_ item: PurchaseItem, costing: Double) {
        let calculator = Calculator(item: item, costing: costing)
        guard let score = calculator.calculate() else {
            error = .couldNotEvaluate
            return
        }
        
        evaluationResult = .positive("Definitely!")
        for pair in thresholdEvaulationPairs {
            if score < pair.threshold {
                evaluationResult = pair.result
            }
        }
    }
    
}
