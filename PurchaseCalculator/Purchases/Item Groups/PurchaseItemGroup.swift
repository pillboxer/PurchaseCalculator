//
//  PurchaseItemGroup.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 09/12/2020.
//

import Foundation
import SystemKit

struct PurchaseItemGroup: Decodable {
    
    let uuid: String
    let itemIDs: [String]
    
}

extension PurchaseItemGroup {
    
    var items: [PurchaseItem]? {
        let items = try? JSONDecoder.decodeLocalJSON(file: "PurchaseItems", type: [String:PurchaseItem].self)
        let values = items.map { $0.values }
        return values?.filter { itemIDs.contains($0.uuid) }
    }

}
