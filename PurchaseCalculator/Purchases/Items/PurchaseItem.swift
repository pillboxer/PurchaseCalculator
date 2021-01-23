//
//  PurchaseItem.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import Foundation

struct PurchaseItem: Decodable, Identifiable, Equatable {
    
    let uuid: String
    let handle: String
    let attributeMultiplierGroupID: String
    let specificPurchaseUnitGroupID: String
    let imageName: String

    var id: String {
        uuid
    }

}

extension PurchaseItem {
    
    private var unitGroup: SpecificPurchaseUnitGroup? {
        let groups = DecodedObjectProvider.specificPurchaseUnitGroups
        return groups?.filter { $0.uuid == specificPurchaseUnitGroupID }.first
    }
    
    var specificPurchaseUnits: [SpecificPurchaseUnit]? {
        unitGroup?.specificPurchaseUnits
    }
    
    var brands: [PurchaseBrand] {
        let brandsWithDuplicates = specificPurchaseUnits?.compactMap { $0.brand } ?? []
        let withoutDuplicates = Set(brandsWithDuplicates)
        return Array(withoutDuplicates)
    }

}
