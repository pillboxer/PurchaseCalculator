//
//  BasicGridSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 23/01/2021.
//

import SwiftUI

struct BasicGridSelectionView<Content: View>: View {
    
    var header: String
    var content: () -> Content
    
    
    private let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    init(header: String, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }
    
    var body: some View {
        BasicNavigationView {
            ListContainerView(headerText: header) {
                LazyVGrid(columns: layout, spacing: 20) {
                    content()
                }
                .padding()
            }
        }
    }
    
}
