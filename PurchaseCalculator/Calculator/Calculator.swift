//
//  Calculator.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import Combine

class Calculator: ObservableObject {
    
    @Published private(set) var score: Double
    
    init(initialScore: Double) {
        self.score = initialScore
    }
    
    func selectOption(_ option: QuestionOption) {
        score *= option.multiplier
    }
    
    func deselectOption(_ option: QuestionOption) {
        score /= option.multiplier
    }
    
}
