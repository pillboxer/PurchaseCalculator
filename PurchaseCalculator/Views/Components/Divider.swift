//
//  Divider.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 23/12/2020.
//

import SwiftUI
struct Divider: View {
    
    var horizontal: Bool = true
    
    var body: some View {
        Rectangle()
            .fill(Color.primary)
            .edgesIgnoringSafeArea(horizontal ? .horizontal : .vertical)
            .frame(maxWidth: horizontal ? .infinity : 1, maxHeight: horizontal ? 1 : .infinity)
    }
}


