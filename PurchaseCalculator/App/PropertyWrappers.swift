//
//  PropertyWrappers.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 28/11/2020.
//

import Foundation

@propertyWrapper
struct EphemeralConsidered<Value> {
    
    var ephemeral: Value
    var notEphemeral: Value
    
    var wrappedValue: Value {
        get {
            #if EPHEMERAL
                return ephemeral
            #else
                return notEphemeral
            #endif
        }
    }
}

@propertyWrapper
struct UserDefaultBool {
    
    var key: String
    
    var wrappedValue: Bool {
        get {
            if UserDefaults.standard.value(forKey: key) == nil {
                return true
            }
            return UserDefaults.standard.bool(forKey: key)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    
}
