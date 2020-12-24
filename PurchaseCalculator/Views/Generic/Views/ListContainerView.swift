//
//  ListContainerView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI

struct ListContainerView<T: View>: View {
    
    let headerText: String
    let list: T
    
    var body: some View {
        VStack {
            Spacer()
            Text(headerText)
                .modifier(StandardFontModifier())
                .padding()
            list
        }
    }
}
