//
//  EvaluationManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 22/11/2020.
//

import Foundation
import SwiftUI

class EvaluationManager: ObservableObject {
    
    // MARK: - Private
    private var regretLikelihoodPercentage: Int?
    private let item: PurchaseItem
    static var penalty: Double {
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
    func evaluateUnit(_ unit: SpecificPurchaseUnit) -> Evaluation? {
        guard let multiplierGroupForItem = multiplierGroupForItem(item) else {
            return nil
        }
        var attributeEvaluations = [AttributeEvaluation]()
        let calculator = Calculator()
        
        for (id, multiplier) in multiplierGroupForItem.attributeMultipliers {
            let name = nameForAttributeID(id)
            let symbol = symbolNameForAttributeID(id)
            let weight = user?.weightForAttributeID(id) ?? 0.5
            
            let attributeEvaluation = AttributeEvaluation.createWith(attributeName: name, attributeScore: multiplier, attributeImageName: symbol, userWeightingScore: weight)
            attributeEvaluations.append(attributeEvaluation)
            calculator.calculate(multiplier: multiplier, weight: weight)
        }
        
        let percentageOfTakeHomePay = user?.amountAsPerCentOfTakeHomePay(unit.cost) ?? 0
        let shouldApplyPenalty =  percentageOfTakeHomePay > 5
        if shouldApplyPenalty {
            calculator.applyPenalty(EvaluationManager.penalty)
        }
        let sortedEvaluations = attributeEvaluations.sorted { $0.attributeName < $1.attributeName }
        return Evaluation.createWith(itemName: item.handle, unitCost: unit.cost, score: calculator.score, attributeEvaluations: sortedEvaluations, penaltyApplied: shouldApplyPenalty)
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
        DecodedObjectProvider.multiplierGroups?.filter { $0.uuid == item.attributeMultiplierGroupID }.first
    }
    
    private var purchaseAttributes: [PurchaseAttribute] {
        DecodedObjectProvider.attributes() ?? []
    }
    
    private func symbolNameForAttributeID(_ id: String) -> String {
        purchaseAttributes.filter { $0.uuid == id }.first?.symbol ?? "exclamationmark.triangle.fill"
    }
    
    private func nameForAttributeID(_ id: String) -> String {
        return purchaseAttributes.filter { $0.uuid == id }.first?.handle ?? ""
    }
    
}
