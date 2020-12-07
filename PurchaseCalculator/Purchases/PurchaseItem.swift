//
//  PurchaseItem.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import Foundation

struct PurchaseItem: Decodable, RowType {
    
    let uuid: String
    let title: String
    let attributeMultiplierGroupID: String
    let imageName: String
    
    var id: String {
        uuid
    }
    
    var isSystemImage: Bool {
        false
    }
}
