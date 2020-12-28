//
//  BackButtonView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct BasicNavigationView<Content: View>: View {
    
    let content: () -> Content
    var imageHidden: Bool = false
    private let isHome: Bool

    init(home: Bool = false, imageHidden: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.isHome = home
        self.imageHidden = imageHidden
        self.content = content
    }
    var body: some View {
        VStack(alignment: .leading) {
            StackPopButtonWithImageView(imageName: isHome ? "house" : "chevron.backward.square")
                .hidden(imageHidden)
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationBarHidden(true)
    }
}

extension BasicNavigationView {
    
    private func hidePopImage(_ bool: Bool) -> BasicNavigationView {
        return BasicNavigationView(imageHidden: bool, content: content)
    }

}
