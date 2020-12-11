//
//  SpecificPurchaseUnitGroup.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 11/12/2020.
//

import Foundation

class SpecificPurchaseUnitGroup: Decodable {
    
    var uuid: String
    var unitIDs: [String]
    
}

extension SpecificPurchaseUnitGroup {
    
    var specificPurchaseUnits: [SpecificPurchaseUnit]? {
        let items = try? JSONDecoder.decodeLocalJSON(file: "SpecificPurchaseUnits", type: [SpecificPurchaseUnit].self)
        return items?.filter { unitIDs.contains($0.uuid) }
    }

}
