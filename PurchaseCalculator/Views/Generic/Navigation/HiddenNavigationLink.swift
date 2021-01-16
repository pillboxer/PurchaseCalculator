//
//  HiddenNavigationLink.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 16/01/2021.
//

import SwiftUI

struct HiddenNavigationLink<Content: View>: View {
    
    var destination: Content
    @Binding var isActive: Bool
    
    var body: some View {
        NavigationLink("", destination: destination, isActive: $isActive)
            .frame(width: 0, height: 0)
    }
    
}
