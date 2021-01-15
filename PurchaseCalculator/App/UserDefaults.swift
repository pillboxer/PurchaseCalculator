//
//  UserDefaults.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 14/12/2020.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKey: String {
        case isFirstLaunch
        case hasEvaluationHistory
    }
    
    @UserDefault(key: .isFirstLaunch, defaultValue: true)
    static var isFirstLaunch
    
    @UserDefault(key: .hasEvaluationHistory, defaultValue: false)
    static var hasEvaluationHistory

}
