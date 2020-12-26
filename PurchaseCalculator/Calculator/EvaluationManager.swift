//
//  EvaluationManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 22/11/2020.
//

import Foundation
import SwiftUI

class EvaluationManager {
    
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
    func evaluateItem(costing itemCost: Double) -> Evaluation {
        guard let multiplierGroupForItem = multiplierGroupForItem(item) else {
            return Evaluation(itemName: "Name not available", score: 0, result: .negative, attributeEvaluations: [])
        }
        var attributeEvaluations = [AttributeEvaluation]()
        let calculator = Calculator()
        
        for (id, multiplier) in multiplierGroupForItem.attributeMultipliers {
            let name = nameForAttributeID(id)
            let result = AttributeResult(score: multiplier)
            let symbol = symbolNameForAttributeID(id)
            let weight = user?.weightForAttributeID(id) ?? 0.5
            let weightingType = AttributeUserWeighting(weight: weight)
            let valuation = AttributeEvaluation(attributeName: name, attributeScore: multiplier, attributeImageName: symbol, userWeighting: weightingType, attributeResult: result)
            attributeEvaluations.append(valuation)
            calculator.calculate(multiplier: multiplier, weight: weight)
        }
        
        let percentageOfTakeHomePay = user?.amountAsPerCentOfTakeHomePay(itemCost) ?? 0
        let penalty = percentageOfTakeHomePay > 5 ? 0.6 : 1
        calculator.applyPenalty(penalty)
        let result = EvaluationResult(score: calculator.score)
        let sortedEvaluations = attributeEvaluations.sorted { $0.attributeName < $1.attributeName }
        return Evaluation(itemName: item.handle, score: calculator.score, result: result, attributeEvaluations: sortedEvaluations)
    }
    
    // MARK: - Helper Methods
    func multiplierGroupForItem(_ item: PurchaseItem) -> PurchaseAttributeMultiplierGroup? {
        try? JSONDecoder.decodeLocalJSON(file: "PurchaseItemAttributeMultipliersGroups", type: [PurchaseAttributeMultiplierGroup].self)
            .filter { $0.uuid == item.attributeMultiplierGroupID }
            .first
    }
    
    private var purchaseAttributes: [PurchaseAttribute] {
        (try? JSONDecoder.decodeLocalJSON(file: "PurchaseAttributes", type: [PurchaseAttribute].self)) ?? []
    }
    
    func symbolNameForAttributeID(_ id: String) -> String {
        purchaseAttributes.filter { $0.uuid == id }.first?.symbol ?? "exclamationmark.triangle.fill"
    }
    
    func nameForAttributeID(_ id: String) -> String {
        return purchaseAttributes.filter { $0.uuid == id }.first?.handle ?? ""
    }
    
}

extension EvaluationManager {
    
    struct Evaluation {
        let itemName: String
        let score: Double
        let result: EvaluationResult
        let attributeEvaluations: [AttributeEvaluation]
        
        var regretLikelihood: String {
            let regretLikelihoodPercentage = 100 - Int(score * 100)
            return "\(regretLikelihoodPercentage)%"
        }
    }
    
    struct AttributeEvaluation: Equatable {
        let attributeName: String
        let attributeScore: Double
        let attributeImageName: String
        let userWeighting: AttributeUserWeighting
        let attributeResult: AttributeResult
    }
    
    enum AttributeUserWeighting: Equatable {
        case low(Double)
        case medium(Double)
        case high(Double)
        
        static func weightingFor(_ weight: Double) -> AttributeUserWeighting {
            if weight < 0.25 {
                return .low(weight)
            }
            if weight < 0.75 {
                return .medium(weight)
            }
            else {
                return .high(weight)
            }
        }
        
        var score: Double {
            switch self {
            case .low(let score):
                return score
            case .medium(let score):
                return score
            case .high(let score):
            return score
            }
        }
        
        var description: String {
            switch self {
            case .low:
                return "low"
            case .medium:
                return "medium"
            case .high:
                return "high"
            }
        }
        
        init(weight: Double) {
            self = AttributeUserWeighting.weightingFor(weight)
        }
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
    
    enum AttributeResult: String, CaseIterable {
        case veryPoor = "very poor"
        case poor
        case average
        case good
        case veryGood = "very good"
        
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
        
        private var rgb: (red: Double, green: Double, blue: Double) {
            switch self {
            case .veryPoor:
                return (1, 0.2, 0.2)
            case .poor:
                return (1, 0.7, 0.4)
            case .average:
                return (1, 1, 0.2)
            case .good:
                return (0.3, 1, 1)
            case .veryGood:
                return (0.4, 1, 0.4)
            }
        }
        
        var evaluationColor: Color {
            return Color(red: rgb.red, green: rgb.green, blue: rgb.blue, opacity: 1)
        }
        
        init(score: Double) {
            for type in AttributeResult.allCases {
                if score <= type.threshold {
                    self = type
                    return
                }
            }
            self = .veryGood
        }
    }

}
