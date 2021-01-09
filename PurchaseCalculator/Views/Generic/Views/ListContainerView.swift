//
//  ListContainerView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI

struct ListContainerView<Content: View>: View {
    
    let headerText: String
    let content: () -> Content
    
    init(headerText: String, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.headerText = headerText
    }
    
    var body: some View {
        Label(headerText)
            .padding()
        ScrollView {
            content()
        }
        
    }
}
