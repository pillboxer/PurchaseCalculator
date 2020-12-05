//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userPreferencesViewModel = UserPreferencesViewModel()
    @ObservedObject var purchaseCategoryViewModel = PurchaseCategoriesViewModel()
    
    init() {
        self.showPreferences = !User.doesExist
    }
    
    @State var showPreferences: Bool = false
    @State var showCategories = false
    
    var body: some View {
        NavigationView {
            if showPreferences {
                UserPreferencesView()
                    .environmentObject(userPreferencesViewModel)
                    .navigationBarTitle("Your Purchase Calculator", displayMode: .inline)
            }
            else {
                if showCategories {
                    PurchaseCategorySelectionView()
                        .environmentObject(purchaseCategoryViewModel)
                }
                else {
                    VStack {
                        Button("Choose a category") {
                            showCategories = true
                        }
                        .padding()
                        Button("Preferences") {
                            showPreferences = true
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
