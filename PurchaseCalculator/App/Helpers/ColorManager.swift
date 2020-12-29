//
//  ColorManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 28/12/2020.
//
import SwiftUI

protocol ColorProvider {
    var lowThreshold: Double { get }
    var mediumLowThreshold: Double { get }
    var mediumHighThreshold: Double { get }
    var highThreshold: Double { get }
    var colorScore: Double { get }
}

extension ColorProvider {
    
    var lowThreshold: Double {
        0.25
    }
    
    var mediumLowThreshold: Double {
        0.5
    }
    
    var mediumHighThreshold: Double {
        return 0.75
    }
    
    var highThreshold: Double {
        1
    }

}

class ColorManager {
    
    static func evaulationResultColorFor(_ provider: ColorProvider) -> Color {
        let red: Double
        let blue: Double
        let green: Double
        
        let score = provider.colorScore
        
        if score <= provider.lowThreshold {
            red = 1-score
            blue = 0
            green = score
        }
        else if score < provider.mediumLowThreshold {
            red = 1
            green = min(score * 2, 1)
            blue = score
        }
        else if score < provider.mediumHighThreshold {
            red = score / 2
            green = min(score * 1.5, 0.8)
            blue = min(score * 1.5, 1)
        }
        else {
            red = 1-score
            green = score * 0.8
            blue = max(0.3, 1-score)
        }
        
        return Color(red: red, green: green, blue: blue, opacity: 1)
        
    }
    
}
