//
//  QuestionOption.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import Foundation

class QuestionOption: Decodable, Identifiable {
    
    let title: String
    let multiplier: Double
    
}

// MARK: - Equatable Conformance
extension QuestionOption: Equatable {
    
    static func == (lhs: QuestionOption, rhs: QuestionOption) -> Bool {
        lhs.id == rhs.id
    }

}
