//
//  SpecificPurchaseUnit.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/12/2020.
//

import Foundation

class SpecificPurchaseUnit: Decodable, CustomStringConvertible {
    
    let uuid: String
    let brandID: String
    let modelName: String
    let cost: Double
    
    var description: String {
        "\(modelName) | \(cost)"
    }
    
    
}
