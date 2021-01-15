//
//  HomescreenBlockContainer.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 02/01/2021.
//

import Foundation

struct BlockContainer: Decodable {
    
    let blockIDs: [String]
    let uuid: String
    let isHidden: Bool?
    let position: Int
    
    enum CodingKeys: CodingKey {
        case blockIDs
        case uuid
        case isHidden
        case position
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let isHidden = try? container.decode(Int.self, forKey: .isHidden) as NSNumber
        let isHiddenBool = isHidden?.boolValue ?? false
        let blockIDs = try container.decode([String].self, forKey: .blockIDs)
        let uuid = try container.decode(String.self, forKey: .uuid)
        let position = try container.decode(Int.self, forKey: .position)
        self.isHidden = isHiddenBool
        self.uuid = uuid
        self.blockIDs = blockIDs
        self.position = position
        
    }
    
}

extension BlockContainer {
    
    var homescreenBlocks: [ScreenBlock]? {
        DecodedObjectProvider.homescreenBlocks?.filter { blockIDs.contains($0.uuid) }.sorted { $0.position < $1.position }
    }
    
    var evaluationBlocks: [ScreenBlock]? {
        DecodedObjectProvider.evaluationScreenBlocks?.filter { blockIDs.contains($0.uuid) }.sorted { $0.position < $1.position }
    }

}
