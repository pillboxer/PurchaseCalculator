//
//  HomescreenBlock.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 01/01/2021.
//

import PurchaseCalculatorDataKit

struct HomescreenBlock: Decodable, Equatable {
    
    let handle: String
    let isWide: Bool
    let imageName: String
    let uuid: String
    let destination: BlockDestination
    
    enum CodingKeys: CodingKey {
        case handle
        case isWide
        case imageName
        case destination
        case uuid
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let destinationString = try container.decode(String.self, forKey: .destination)
        print(destinationString)
        let destination = BlockDestination(rawValue: destinationString) ?? .preferences
        let isWide = try container.decode(Int.self, forKey: .isWide) as NSNumber
        let isWideBool = isWide.boolValue
        let imageName = try container.decode(String.self, forKey: .imageName)
        let handle = try container.decode(String.self, forKey: .handle)
        let uuid = try container.decode(String.self, forKey: .uuid)
        
        self.destination = destination
        self.isWide = isWideBool
        self.imageName = imageName
        self.handle = handle
        self.uuid = uuid
        
    }
    
}
