//
//  SpecificPurchaseUnit.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/12/2020.
//

import SystemKit

struct SpecificPurchaseUnit: Decodable, CustomStringConvertible, Equatable, RowType {
    
    let uuid: String
    let brandID: String
    let modelName: String
    let cost: Double
    let evaluationCount: Int?
    
    var description: String {
        "\(modelName) | \(cost)"
    }
    
    var rowTitle: String {
        "\(modelName) (\(brandName))"
    }
    
    var imageName: String {
        item?.imageName ?? ""
    }
    
    var brandName: String {
        brand?.handle ?? "No Brand"
    }
    
}

extension SpecificPurchaseUnit {
    
    var brand: PurchaseBrand? {
        let brands = DecodedObjectProvider.purchaseBrands
        return brands?.filter { $0.uuid == brandID }.first
    }
    
    var item: PurchaseItem? {
        let items = DecodedObjectProvider.purchaseItems
        let itemsAndUnits = items?.compactMap { (units: $0.specificPurchaseUnits, item: $0) }
        let correctTuple = itemsAndUnits?.filter { $0.units?.contains(self) ?? false }.first
        return correctTuple?.item
    }

}


extension SpecificPurchaseUnit: Identifiable {
    
    var id: String {
        uuid
    }

}
