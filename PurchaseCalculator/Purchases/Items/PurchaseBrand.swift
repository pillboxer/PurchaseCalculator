//
//  PurchaseBrand.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 12/12/2020.
//

import Foundation

struct PurchaseBrand: Decodable {

    let uuid: String
    let name: String
    let imageName: String
    
}

extension PurchaseBrand: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

}

extension PurchaseBrand: Equatable {

    static func == (lhs: PurchaseBrand, rhs: PurchaseBrand) -> Bool {
        lhs.uuid == rhs.uuid && lhs.name == rhs.name
    }
    
}

extension PurchaseBrand: RowType {

    var title: String {
        name
    }
    
}

