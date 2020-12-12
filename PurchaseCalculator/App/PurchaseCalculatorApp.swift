//
//  PurchaseCalculatorApp.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

@main
struct PurchaseCalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var manager = FirebaseManager.shared
    var body: some Scene {
        WindowGroup {
            if manager.isLoadingJSON {
                Text("Loading")
            }
            else {
                ContentView()
            }
        }
    }
}
