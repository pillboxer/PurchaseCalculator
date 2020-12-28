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
    private static var penalty: Double {
        0.8
    }
    
    private var user: User? {
        User.existingUser
    }
    
    // MARK: - Initialisation
    init(item: PurchaseItem) {
        self.item = item
    }
    
    // MARK: - Evaluation
    func evaluateUnit(_ unit: SpecificPurchaseUnit) -> Evaluation {
        guard let multiplierGroupForItem = multiplierGroupForItem(item) else {
            // FIXME: - This should return an error
            return Evaluation(itemName: "Name not available", unitCost: 0, score: 0, result: .negative, attributeEvaluations: [], penaltyApplied: false)
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
        
        let percentageOfTakeHomePay = user?.amountAsPerCentOfTakeHomePay(unit.cost) ?? 0
        let shouldApplyPenalty =  percentageOfTakeHomePay > 5
        if shouldApplyPenalty {
            calculator.applyPenalty(EvaluationManager.penalty)
        }
        let result = EvaluationResult(score: calculator.score)
        let sortedEvaluations = attributeEvaluations.sorted { $0.attributeName < $1.attributeName }
        return Evaluation(itemName: item.handle, unitCost: unit.cost, score: calculator.score, result: result, attributeEvaluations: sortedEvaluations, penaltyApplied: shouldApplyPenalty)
    }
    
    private func debugCalculations(name: String, multiplier: Double, weighting: Double, currentScore: Double) {
        print("The attribute is: \(name)")
        print("The multiplier is: \(multiplier)")
        print("The users weighting for \(name) is \(weighting)")
        print("The score is now \(currentScore)")
        print("---------------------------------------------------\n")
    }
    
    // MARK: - Helper Methods
    private func multiplierGroupForItem(_ item: PurchaseItem) -> PurchaseAttributeMultiplierGroup? {
        try? JSONDecoder.decodeLocalJSON(file: "PurchaseItemAttributeMultipliersGroups", type: [PurchaseAttributeMultiplierGroup].self)
            .filter { $0.uuid == item.attributeMultiplierGroupID }
            .first
    }
    
    private var purchaseAttributes: [PurchaseAttribute] {
        (try? JSONDecoder.decodeLocalJSON(file: "PurchaseAttributes", type: [PurchaseAttribute].self)) ?? []
    }
    
    private func symbolNameForAttributeID(_ id: String) -> String {
        purchaseAttributes.filter { $0.uuid == id }.first?.symbol ?? "exclamationmark.triangle.fill"
    }
    
    private func nameForAttributeID(_ id: String) -> String {
        return purchaseAttributes.filter { $0.uuid == id }.first?.handle ?? ""
    }
    
}

// MARK: - Evaluation
extension EvaluationManager {

    struct Evaluation {
        let itemName: String
        let unitCost: Double
        let score: Double
        let result: EvaluationResult
        let attributeEvaluations: [AttributeEvaluation]
        let penaltyApplied: Bool
        
        var alignmentPercentageString: String {
            let percentage = (scoreWithoutPenalty * 100).to(decimalPlaces: 2)
            let withThreshold = min(100, percentage)
            return "\(withThreshold)%"
        }
        
        private var scoreWithoutPenalty: Double {
            guard penaltyApplied else {
                return score
            }
            return score / penalty
        }
        
        var reasonToBuy: AttributeEvaluation? {
            // FIXME: - Change to be more personalised
            attributeEvaluations.sorted { ($0.attributeResult.colorScore > $1.attributeResult.colorScore) }.first
        }
        
        var reasonToAvoid: AttributeEvaluation? {
            attributeEvaluations.sorted { ($0.attributeResult.colorScore < $1.attributeResult.colorScore) }.first
        }
        
    }
    
}

// MARK: - EvaluationResult
extension EvaluationManager {
    
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
                
    }

}
