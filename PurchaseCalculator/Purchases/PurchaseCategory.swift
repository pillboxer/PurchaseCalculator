//
//  PurchaseCategory.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

struct PurchaseCategory: Decodable, RowType {
    
    let title: String
    let uuid: String
    let purchaseItemIDs: [String]
    let imageName: String
    
    var id: String {
        uuid
    }
    
    var isSystemImage: Bool {
        false
    }
    
}
