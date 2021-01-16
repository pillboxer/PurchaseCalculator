//
//  Strings+Extensions.swift
//  PurchaseCalculatorDataKit
//
//  Created by Henry Cooper on 30/12/2020.
//

import Foundation

public extension String {
    
    static func forKey(_ key: String) -> String {
        guard let json = try? JSONDecoder.decodeLocalJSON(file: "Strings", type: [[String:String]].self) else {
            return key
        }
        return json.first?[key.lowercased()] ?? key
    }

}
