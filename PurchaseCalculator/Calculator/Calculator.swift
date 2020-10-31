//
//  Calculator.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import Foundation

class Calculator {
    
    private(set) var score: Double {
        didSet {
            print("I am now: \(score)")
        }
    }
    
    init(initialScore: Double) {
        self.score = initialScore
    }
    
    func selectOption(_ option: QuestionOption) {
        score *= option.multiplier
    }
    
    
}
