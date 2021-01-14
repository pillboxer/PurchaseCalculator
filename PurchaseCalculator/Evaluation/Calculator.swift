//
//  Calculator.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import Combine
import SystemKit

class Calculator: ObservableObject {
    
    private (set)var score: Double = 1
    
    func calculate(multiplier: Double, weight: Double) {
            // Get the delta of applying the multiplier to the current score
            let delta = score - (score * multiplier)
            // Apply the user's weight to the delta
            let deltaConsideringUsersWeighting = delta * weight
            // Apply the evaluation to the current score
            score = score - deltaConsideringUsersWeighting
    }
    
    func applyPenalty(_ penalty: Double) {
        score *= penalty
    }
    
}
