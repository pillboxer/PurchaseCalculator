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
    let purchaseItemIDs: [String]
    
}

extension PurchaseItemGroup {
    
    var items: [PurchaseItem]? {
        let items = DecodedObjectProvider.purchaseItems
        return items?.filter { purchaseItemIDs.contains($0.uuid) }
    }

}
