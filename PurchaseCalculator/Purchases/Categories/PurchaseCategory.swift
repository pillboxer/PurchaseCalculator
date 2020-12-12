//
//  PurchaseCategory.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//
import SystemKit

struct PurchaseCategory: Decodable, RowType {
    
    let title: String
    let uuid: String
    let purchaseItemGroupID: String
    let imageName: String

}

extension PurchaseCategory {

    var purchaseItemGroup: PurchaseItemGroup? {
        let itemGroups = try? JSONDecoder.decodeLocalJSON(file: "PurchaseItemGroups", type: [PurchaseItemGroup].self)
        return itemGroups?.filter { $0.uuid == purchaseItemGroupID }.first
    }
    
}
