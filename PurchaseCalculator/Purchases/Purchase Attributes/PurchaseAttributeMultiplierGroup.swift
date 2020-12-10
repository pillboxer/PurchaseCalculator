//
//  PurchaseAttributeMutliplierGroup.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 22/11/2020.
//

import Foundation

struct PurchaseAttributeMultiplierGroup: Decodable {
    
    let uuid: String
    let attributeMultipliers: [String : Double]
    
}
