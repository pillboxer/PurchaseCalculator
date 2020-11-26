//
//  EvaluationManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 22/11/2020.
//

import Foundation
import SwiftUI

class EvaluationManager: ObservableObject {
    
    @Published var error: EvaluationError?
    @Published var evaluationResult: EvaluationResult?
    
    private let user: User
    
    init?(user: User? = User.existingUser) {
        guard let user = user else {
            return nil
        }
        self.user = user
    }

    enum EvaluationError: String {
        case couldNotEvaluate = "Could not evaluate, please try again"
        
        var message: String {
            rawValue
        }
    }
    
    var thresholdEvaulationPairs: [(threshold: Double, result: EvaluationResult)] {
        [
            (1, .positive("Looks Like A Good Buy")),
            (0.8, .neutral("Sleep On It")),
            (0.6, .neutral("Wait One Week")),
            (0.5, .negative("Definitely Not"))
        ]
    }
    
    enum EvaluationResult {
        case negative(String)
        case neutral(String)
        case positive(String)
        
        var textColor: Color {
            switch self {
            case .negative:
                return .red
            case .neutral:
                return .orange
            case .positive:
                return .green
            }
        }
        
        var resultMessage: String {
            switch self {
            case.negative(let message):
                return "👎: \(message)"
            case .neutral(let message):
                return "🤔: \(message)"
            case .positive(let message):
                return "👍🏽: \(message)"
            }
        }
    }
        
    func evaluate(_ item: PurchaseItem, costing itemCost: Double) {
        guard let multiplierGroupForItem = multiplierGroupForItem(item) else {
            return
        }
        
        let calculator = Calculator()
        for (id, multiplier) in multiplierGroupForItem.attributeMultipliers {
            let weight = user.weightForAttributeID(id) ?? 0.5
            calculator.calculate(multiplier: multiplier, weight: weight)
        }
        
        let percentageOfTakeHomePay = user.amountAsPerCentOfTakeHomePay(itemCost)
        let penalty = percentageOfTakeHomePay > 5 ? 0.6 : 1
        calculator.applyPenalty(penalty)
        evaluationResult = .positive("Definitely!")
        for pair in thresholdEvaulationPairs {
            if calculator.score < pair.threshold {
                evaluationResult = pair.result
            }
        }
    }
    
    func multiplierGroupForItem(_ item: PurchaseItem) -> PurchaseAttributeMultiplierGroup? {
        try? JSONDecoder.decodeLocalJSON(file: "PurchaseItemAttributeMultipliersGroups", type: [PurchaseAttributeMultiplierGroup].self)
            .filter { $0.uuid == item.attributeMultiplierGroupID }
            .first
    }
    
}
