//
//  SpecificPurchaseUnitGroup.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 11/12/2020.
//

import Foundation

struct SpecificPurchaseUnitGroup: Decodable {
    
    let uuid: String
    let unitIDs: [String]?
    
}

extension SpecificPurchaseUnitGroup {
    
    var specificPurchaseUnits: [SpecificPurchaseUnit]? {
        guard let unitIDs = unitIDs else {
            return nil
        }
        let units = DecodedObjectProvider.allSpecificPurchaseUnits
        let filtered = units?.filter { unitIDs.contains($0.uuid) }
        return filtered
    }

}
