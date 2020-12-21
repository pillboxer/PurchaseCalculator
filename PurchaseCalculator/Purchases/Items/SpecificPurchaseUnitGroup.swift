//
//  SpecificPurchaseUnitGroup.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 11/12/2020.
//

import Foundation

struct SpecificPurchaseUnitGroup: Decodable {
    
    var uuid: String
    var unitIDs: [String]
    
    enum CodingKeys: String, CodingKey {
        case unitIDs
        case uuid
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try values.decode([String:String].self, forKey: .unitIDs)
        self.unitIDs = dict.map { $0.value }
        self.uuid = try values.decode(String.self, forKey: .uuid)
    }
}

extension SpecificPurchaseUnitGroup {
    
    var specificPurchaseUnits: [SpecificPurchaseUnit]? {
        let items = try? JSONDecoder.decodeLocalJSON(file: "SpecificPurchaseUnits", type: [String:SpecificPurchaseUnit].self)
        let values = items.map { $0.values }
        let filtered = values?.filter { unitIDs.contains($0.uuid) }
        return filtered
    }

}
