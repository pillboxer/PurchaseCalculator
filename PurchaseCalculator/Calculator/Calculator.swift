//
//  Calculator.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import Combine
import SystemKit

class Calculator: ObservableObject {
    
    let item: PurchaseItem
    let itemCost: Double
    var score: Double
    
    init(item: PurchaseItem, costing itemCost: Double, initialScore: Double = 1) {
        self.item = item
        self.itemCost = itemCost
        self.score = initialScore
    }
    
    var multiplierGroup: PurchaseAttributeMultiplierGroup? {
        try? JSONDecoder.decodeLocalJSON(file: "PurchaseItemAttributeMultipliersGroups", type: [PurchaseAttributeMultiplierGroup].self)
            .filter { $0.uuid == item.attributeMultiplierGroupID }
            .first
    }
        
    func calculate() -> Double? {
        guard let multiplierGroup = multiplierGroup else {
            return nil
        }
        for (attributeID, attributeMultiplier) in multiplierGroup.attributeMultipliers {
            // Get the delta of applying the multiplier to the current score
            let delta = score - (score * attributeMultiplier)
            // Look at the user's weighting for this particular attribute
            let usersWeightingForAttribute = PurchaseHelper.usersPurchaseAttributeValueWeightForAttributeID(attributeID)
            // Apply the user's weighting to the delta
            let deltaConsideringUsersWeighting = delta * usersWeightingForAttribute
            // Apply the evaluation to the current score
            score = score - deltaConsideringUsersWeighting
        }
        // Apply penalty if necessary
        let penalty = PurchaseHelper.isGreaterThan5PerCentOfTakeHomePay(itemCost) ? 0.6 : 1
        return score * penalty
    }
    
}
