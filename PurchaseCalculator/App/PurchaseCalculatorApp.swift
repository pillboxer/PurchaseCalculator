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
            if User.doesExist {
                HomescreenView()
            }
            else {
                WelcomeView()
                    .statusBar(hidden: true)
            }
        }
    }
}
