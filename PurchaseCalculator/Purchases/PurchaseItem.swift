//
//  PurchaseItem.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import Foundation

struct PurchaseItem: Decodable, Identifiable {
    
    let uuid: String
    let itemHandle: String
    let attributeMultiplierGroupID: String
    
    var id: String {
        uuid
    }
    
}
