//
//  HomescreenBlock.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 01/01/2021.
//

import PurchaseCalculatorDataKit

struct ScreenBlock: Decodable {
        
    let handle: String
    let isWide: Bool
    let image: ImageWrapper
    let uuid: String
    let destination: BlockDestination
    let position: Int
    
    enum CodingKeys: CodingKey {
        case handle
        case isWide
        case imageName
        case destination
        case uuid
        case position
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let destinationString = try container.decode(String.self, forKey: .destination)
        let destination = BlockDestination(rawValue: destinationString) ?? .error
        let isWide = try container.decode(Int.self, forKey: .isWide) as NSNumber
        let isWideBool = isWide.boolValue
        let imageName = try container.decode(String.self, forKey: .imageName)
        let handle = try container.decode(String.self, forKey: .handle)
        let uuid = try container.decode(String.self, forKey: .uuid)
        let position = try? container.decode(Int.self, forKey: .position)
        
        self.destination = destination
        self.isWide = isWideBool
        self.image = ImageWrapper(name: imageName, renderingMode: .original)
        self.handle = handle
        self.uuid = uuid
        self.position = position ?? 0
    }
    
}
