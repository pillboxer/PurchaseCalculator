//
//  AttributeEvaluation.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 28/12/2020.
//

import Foundation

struct AttributeEvaluation: Equatable {
    let attributeName: String
    let attributeScore: Double
    let attributeImageName: String
    let userWeighting: AttributeUserWeighting
    let attributeResult: AttributeResult
}
