//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = NewUserViewModel()
    var body: some View {
        NavigationView {
            if !User.doesExist {
                NewUserView().environmentObject(model)
                    .navigationBarTitle("Your Purchase Calculator", displayMode: .inline)
            }
            else {
                Text("Hello there")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
