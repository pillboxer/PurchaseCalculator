//
//  EvaluationManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 22/11/2020.
//

import Foundation
import SwiftUI

class EvaluationManager: ObservableObject {
    
    var evaluation: Evaluation?

    // MARK: - Private
    private var regretLikelihoodPercentage: Int?
    private let item: PurchaseItem
    
    private var user: User? {
        User.existingUser
    }
    
    // MARK: - Initialisation
    init(item: PurchaseItem) {
        self.item = item
    }
    
    // MARK: - Evaluation
    func evaluateItem(costing itemCost: Double) {
        guard let multiplierGroupForItem = multiplierGroupForItem(item) else {
            return
        }
        var attributeEvaluations = [AttributeEvaluation]()
        let calculator = Calculator()
        
        for (id, multiplier) in multiplierGroupForItem.attributeMultipliers {
            let name = nameForAttributeID(id)
            print("Evaluating against \(name)")
            print("Score for \(name) is \(multiplier)")
            let result = AttributeResult(score: multiplier)
            let valuation = AttributeEvaluation(attributeName: name, attributeResult: result)
            attributeEvaluations.append(valuation)
            let weight = user?.weightForAttributeID(id) ?? 0.5
            print("User cares about \(name): \(weight)")
            calculator.calculate(multiplier: multiplier, weight: weight)
            print("--------------------------------------")
        }
        
        let percentageOfTakeHomePay = user?.amountAsPerCentOfTakeHomePay(itemCost) ?? 0
        let penalty = percentageOfTakeHomePay > 5 ? 0.6 : 1
        calculator.applyPenalty(penalty)
        let result = EvaluationResult(score: calculator.score)
        evaluation = Evaluation(score: calculator.score, result: result, attributeEvaluations: attributeEvaluations)
    }
    
    // MARK: - Helper Methods
    func multiplierGroupForItem(_ item: PurchaseItem) -> PurchaseAttributeMultiplierGroup? {
        try? JSONDecoder.decodeLocalJSON(file: "PurchaseItemAttributeMultipliersGroups", type: [PurchaseAttributeMultiplierGroup].self)
            .filter { $0.uuid == item.attributeMultiplierGroupID }
            .first
    }
    
    func nameForAttributeID(_ id: String) -> String {
        (try? JSONDecoder.decodeLocalJSON(file: "PurchaseAttributes", type: [PurchaseAttribute].self).filter { $0.uuid == id }.first?.handle) ?? ""
    }
    
}

extension EvaluationManager {
    
    struct Evaluation {
        let score: Double
        let result: EvaluationResult
        let attributeEvaluations: [AttributeEvaluation]
        
        var regretLikelihood: String {
            let regretLikelihoodPercentage = 100 - Int(score * 100)
            return "\(regretLikelihoodPercentage)%"
        }
    }
    
    struct AttributeEvaluation {
        let attributeName: String
        let attributeResult: AttributeResult
    }
    
    enum EvaluationResult: CaseIterable {
                
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
            switch self {
            case .negative:
                return "Don't bother"
            case .neutralLow:
                return "Wait ten days"
            case .neutralHigh:
                return "Sleep on it"
            case .positive:
                return "Go for it"
            }
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
        
        private var rgb: (red: Double, green: Double, blue: Double) {
            switch self {
            case .negative:
                return (1, 0.7, 0.4)
            case .neutralLow:
                return (1, 1, 0.2)
            case .neutralHigh:
                return (0.3, 1, 1)
            case .positive:
                return (0.4, 1, 0.4)
            }
        }
        
        var evaluationColor: Color {
            return Color(red: rgb.red, green: rgb.green, blue: rgb.blue, opacity: 1)
        }
    }
    
    enum AttributeResult: CaseIterable {
        case veryPoor
        case poor
        case average
        case good
        case veryGood
        
        var threshold: Double {
            switch self {
            case .veryPoor:
                return 0.25
            case .poor:
                return 0.5
            case .average:
                return 1
            case .good:
                return 1.3
            default:
                return 1
            }
        }
        
        init(score: Double) {
            for type in AttributeResult.allCases {
                if score < type.threshold {
                    self = type
                    return
                }
            }
            self = .veryGood
        }
    }

}
