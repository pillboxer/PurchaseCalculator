//
//  PurchaseCalculatorApp.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

@main
struct PurchaseCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(QuestionProvider())
        }
    }
}
