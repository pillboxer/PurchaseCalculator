//
//  String+Extensions.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/01/2021.
//

#if os(iOS)
import UIKit

public extension String {
    
    var existsAsImage: Bool {
        UIImage(named: self) != nil
    }
    
}
#endif

public extension String {
    
    func snakeCased() -> String {
        let pattern = "([a-z0-9])([A-Z])"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased() ?? self
    }
    
    mutating func safeRemove(at index: String.Index?) {
        if let index = index {
            remove(at: index)
        }
    }
    
}
