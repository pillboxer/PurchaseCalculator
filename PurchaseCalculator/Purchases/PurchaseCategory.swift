//
//  PurchaseCategory.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SystemKit

struct PurchaseCategory: Decodable {
    
    let categoryHandle: String
    let uuid: String
    let purchaseItemIDs: [String]
    
}
