//
//  PurchaseBrand.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 12/12/2020.
//

import Foundation

struct PurchaseBrand: Decodable, Identifiable {

    let uuid: String
    let handle: String
    let imageName: String
    
    var id: String {
        uuid
    }
    
}

extension PurchaseBrand {
    
    var units: [SpecificPurchaseUnit]? {
        DecodedObjectProvider.specificPurchaseUnits?.filter { $0.brand == self }
    }

}

extension PurchaseBrand: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

