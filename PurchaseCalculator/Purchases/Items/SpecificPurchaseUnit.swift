//
//  SpecificPurchaseUnit.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/12/2020.
//

import SystemKit

struct SpecificPurchaseUnit: Decodable, CustomStringConvertible {
    
    let uuid: String
    let brandID: String
    let modelName: String
    let cost: Double
    
    var description: String {
        "\(modelName) | \(cost)"
    }
    
    
}

extension SpecificPurchaseUnit {
    
    var brand: PurchaseBrand? {
        let brands = try? JSONDecoder.decodeLocalJSON(file: "PurchaseBrands", type: [PurchaseBrand].self)
        return brands?.filter { $0.uuid == brandID }.first
    }

}


extension SpecificPurchaseUnit: Identifiable {
    
    var id: String {
        uuid
    }

}
