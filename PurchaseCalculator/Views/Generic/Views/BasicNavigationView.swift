//
//  BackButtonView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct BasicNavigationView<Content: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        EmptorColorSchemeAdaptingView {
            VStack {
                content()
                Spacer()
                HStack {
                    DismissalButton()
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}
