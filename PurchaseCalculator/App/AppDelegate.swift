//
//  AppDelegate.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/11/2020.
//

import CoreData
import SwiftUI
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        KeyboardListener.start()
        return true
    }
    
}

// MARK: - Other Extensions
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

