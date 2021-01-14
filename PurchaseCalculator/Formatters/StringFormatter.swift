//
//  StringFormatter.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 04/01/2021.
//

import Foundation

protocol StringFormatter {
    var unformattedString: String { get }
    var requiredKeys: [StringFormatterKey] { get }
    func replace(_ string: String, for key: StringFormatterKey) -> String
}

extension StringFormatter {
    
    var formattedString: String {
        var string = String.forKey(unformattedString)
        
        for key in requiredKeys {
            guard string.contains("{") && string.contains("}") else {
                break
            }
            string = replace(string, for: key)
        }
        
        return string
    }
    
}

extension String {
    
    func replacingOccurrences(of target: StringFormatterKey, with replacement: Any?) -> String {
        guard let replacement = replacement else {
            return self
        }
        let stringReplacement = String(describing: replacement)
        return replacingOccurrences(of: String.forKey(target.rawValue), with: String.forKey(stringReplacement))
    }
    
}
