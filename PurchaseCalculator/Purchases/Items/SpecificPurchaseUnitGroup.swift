//
//  SpecificPurchaseUnitGroup.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 11/12/2020.
//

import Foundation

struct SpecificPurchaseUnitGroup: Decodable {
    
    var uuid: String
    let unitIDs: [String]
    
}

extension SpecificPurchaseUnitGroup {
    
    var specificPurchaseUnits: [SpecificPurchaseUnit]? {
        let units = DecodedObjectProvider.specificPurchaseUnits
        let filtered = units?.filter { unitIDs.contains($0.uuid) }
        return filtered
    }

}
