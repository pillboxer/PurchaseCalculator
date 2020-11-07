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
    var body: some Scene {
        WindowGroup {
            if let provider = QuestionProvider() {
                ContentView()
                    .environmentObject(provider)
                    .environment(\.managedObjectContext, appDelegate.context)
            }
            else {
                ContentView()
            }
        }
    }
}
