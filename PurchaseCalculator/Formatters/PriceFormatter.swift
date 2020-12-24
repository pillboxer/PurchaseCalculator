//
//  PriceFormatter.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 23/12/2020.
//

import Foundation

class PriceFormatter {
    
    static func format(cost: Double, currency: Currency) -> String {
        String(format: "\(currency.symbol)%.02f", cost)
    }
    
}
