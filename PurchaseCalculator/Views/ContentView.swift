//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var newUserViewModel = NewUserViewModel()
    @ObservedObject var purchaseSelectionViewModel = PurchaseCategorySelectionViewModel()
    var body: some View {
        NavigationView {
            if !User.doesExist {
                NewUserView()
                    .environmentObject(newUserViewModel)
                    .navigationBarTitle("Your Purchase Calculator", displayMode: .inline)
            }
            else {
                PurchaseCategorySelectionView()
                    .environmentObject(purchaseSelectionViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
