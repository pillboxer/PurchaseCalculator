//
//  SpecificPurchaseUnit.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/12/2020.
//

import SystemKit
import PurchaseCalculatorDataKit

struct SpecificPurchaseUnit: Decodable, Equatable, RowType {
    
    let uuid: String
    let brandID: String
    let modelName: String
    let cost: Double
    let evaluationCount: Int?
    
    var rowTitle: String {
        let formatter = SpecificPurchaseUnitFormatter(unit: self, unformattedString: "specific_purchase_unit_row")
        return formatter.formattedString
    }
    
    var imageName: String? {
        // Don't use the brand object below as it will be nil if using a custom unit
        if let brand = (DecodedObjectProvider.purchaseBrands?.filter { $0.uuid == brandID}.first),
           ImageRetriever.image(named: ImageWrapper(name: brand.imageName).name) != nil {
            return brand.imageName
        }
        return nil
    }
    
    var brandHandle: String {
        brand?.handle ?? item?.handle ?? "Data Missing"
    }
    
}

extension SpecificPurchaseUnit {
    
    var brand: PurchaseBrand? {
        guard item != nil else {
             return nil
        }
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
