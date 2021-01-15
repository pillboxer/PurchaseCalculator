//
//  PropertyWrappers.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 28/11/2020.
//

import Foundation
import SwiftUI

class WrappedDebugging {
    @EphemeralConsidered(ephemeral: false, notEphemeral: true) static var isLive
}

@propertyWrapper
struct EphemeralConsidered<Value> {
    
    var ephemeral: Value
    var notEphemeral: Value
    
    var wrappedValue: Value {
        get {
            #if EPHEMERAL
            print("EPEHEMERAL")
                return ephemeral
            #else
            print("NOT EPHEMERAL")
                return notEphemeral
            #endif
        }
    }
}



@propertyWrapper
struct UserDefault<Value> {
    
    var key: UserDefaults.UserDefaultsKey
    var defaultValue: Value
    
    var wrappedValue: Value {
        get {
            if UserDefaults.standard.value(forKey: key.rawValue) == nil || !WrappedDebugging.isLive {
                return defaultValue
            }
            return UserDefaults.standard.value(forKey: key.rawValue) as? Value ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key.rawValue)
        }
    }
    
}
