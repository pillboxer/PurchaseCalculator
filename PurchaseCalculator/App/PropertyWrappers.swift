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
