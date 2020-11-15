//
//  GlobalEnums.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 15/11/2020.
//

import Foundation

protocol StringedEnum: RawRepresentable {}

// MARK: - Currency
enum Currency: String, CaseIterable, StringedEnum {
    
    case GBP
    case USD
    
}
