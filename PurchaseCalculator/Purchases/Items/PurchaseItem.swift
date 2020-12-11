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
    let purchaseUnitGroupID: String?
    let imageName: String
    
    var id: String {
        uuid
    }

}

extension PurchaseItem {
    
    private var unitGroup: SpecificPurchaseUnitGroup? {
        let groups = try? JSONDecoder.decodeLocalJSON(file: "SpecificPurchaseUnitGroups", type: [SpecificPurchaseUnitGroup].self)
        return groups?.filter { $0.uuid == purchaseUnitGroupID }.first
    }
    
    var specificPurchaseUnits: [SpecificPurchaseUnit]? {
        unitGroup?.specificPurchaseUnits
    }

}
