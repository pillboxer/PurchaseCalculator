//
//  HomescreenBlockContainer.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 02/01/2021.
//

import Foundation

struct HomescreenBlockContainer: Decodable {
    
    let blockIDs: [String]
    let uuid: String
    let isHidden: Bool?
    
    enum CodingKeys: CodingKey {
        case blockIDs
        case uuid
        case isHidden
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let isHidden = try? container.decode(Int.self, forKey: .isHidden) as NSNumber
        let isHiddenBool = isHidden?.boolValue
        let blockIDs = try container.decode([String].self, forKey: .blockIDs)
        let uuid = try container.decode(String.self, forKey: .uuid)
        self.isHidden = isHiddenBool
        self.uuid = uuid
        self.blockIDs = blockIDs
        
    }
    
}

extension HomescreenBlockContainer {
    
    var blocks: [HomescreenBlock]? {
        DecodedObjectProvider.homescreenBlocks?.filter { blockIDs.contains($0.uuid) }.sorted { $0.position < $1.position }
    }

}
