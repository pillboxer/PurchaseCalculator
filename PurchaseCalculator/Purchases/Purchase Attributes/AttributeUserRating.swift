//
//  AttributeUserRating.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 28/12/2020.
//

import SwiftUI

enum AttributeUserWeighting: Equatable, ColorProvider {
    
    case veryLow(Double)
    case low(Double)
    case medium(Double)
    case high(Double)
    case veryHigh(Double)
    
    static private func weightingFor(_ weight: Double) -> AttributeUserWeighting {
        if weight < 0.2 {
            return .veryLow(weight)
        }
        if weight < 0.4 {
            return .low(weight)
        }
        if weight < 0.6 {
            return .medium(weight)
        }
        if weight < 0.8 {
            return .high(weight)
        }
        else {
            return .veryHigh(weight)
        }
    }
    
    var colorScore: Double {
        switch self {
        case .veryLow(let score):
            return score
        case .low(let score):
            return score
        case .medium(let score):
            return score
        case .high(let score):
            return score
        case .veryHigh(let score):
            return score
        }
    }
    
    var description: String {
        switch self {
        case .veryLow:
            return "very low"
        case .low:
            return "low"
        case .medium:
            return "medium"
        case .high:
            return "high"
        case .veryHigh:
            return "very high"
        }
    }
    
    var color: Color {
        ColorManager.evaulationResultColorFor(self)
    }
    
    init(weight: Double) {
        self = AttributeUserWeighting.weightingFor(weight)
    }
}
