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
    }
    
    @UserDefaultBool(key: UserDefaultsKey.isFirstLaunch.rawValue)
    static var isFirstLaunch

}
