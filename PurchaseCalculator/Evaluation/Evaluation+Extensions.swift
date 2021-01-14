//
//  Evaluation+Extensions.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 14/01/2021.
//

import Foundation

extension Evaluation {
    
    var alignmentPercentageString: String {
        let percentage = (scoreWithoutPenalty * 100).to(decimalPlaces: 2)
        let withThreshold = min(100, percentage)
        return "\(withThreshold)%"
    }
    
    var result: EvaluationResult {
        EvaluationResult(score: score)
    }
    
    private var scoreWithoutPenalty: Double {
        guard penaltyApplied else {
            return score
        }
        return score / EvaluationManager.penalty
    }
    
    var attributeEvaluationArray: [AttributeEvaluation] {
        attributeEvaluations.allObjects as? [AttributeEvaluation] ?? []
    }
    
    var reasonToBuy: AttributeEvaluation? {
        attributeEvaluationArray.sorted { $0.attributeScore * $0.userWeighting.score > $1.attributeScore * $1.userWeighting.score }.first
    }
    
    var reasonToAvoid: AttributeEvaluation? {
        attributeEvaluationArray.sorted { (1-$0.attributeScore) * $0.userWeighting.score > (1-$1.attributeScore) * $1.userWeighting.score }.first
    }

}
