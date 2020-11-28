//
//  PurchaseCategory.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

struct PurchaseCategory: Decodable, Identifiable {
    
    let categoryHandle: String
    let uuid: String
    let purchaseItemIDs: [String]
    
    var id: String {
        uuid
    }
    
}
