//
//  Double+Extensions.swift
//  SystemKit
//
//  Created by Henry Cooper on 27/12/2020.
//

import Foundation

public extension Double {
    
    func to(decimalPlaces: Int) -> Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = decimalPlaces
        let number = NSNumber(floatLiteral: self)
        let formatted = numberFormatter.string(from: number) ?? ""
        return Double(formatted) ?? 0
    }
    
    func dateString(_ style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        return formatter.string(from: Date(timeIntervalSince1970: self))
    }

}
