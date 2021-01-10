//
//  EmptorColorSchemeAdaptingView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 10/01/2021.
//

import SwiftUI

struct EmptorColorSchemeAdaptingView<Content: View>: View {
    
    
    private let content: () -> Content
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Color.colorSchemeConsidered
                .edgesIgnoringSafeArea(.all)
            content()
        }
        .navigationBarHidden(true)
    }
    
}
