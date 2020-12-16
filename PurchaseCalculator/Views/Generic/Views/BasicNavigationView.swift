//
//  BackButtonView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct BasicNavigationView<Content: View>: View {
    
    let content: Content
    private let isHome: Bool

    init(home: Bool = false, @ViewBuilder content: () -> Content) {
        self.isHome = home
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading) {
            StackPopButtonWithImageView(imageName: isHome ? "house" : "chevron.backward.square")
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
