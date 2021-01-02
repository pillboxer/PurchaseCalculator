//
//  HomescreenBlockHelper.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 01/01/2021.
//

import SwiftUI

class HomescreenBlockHelper {
    
    @ViewBuilder
    func view(for block: HomescreenBlock) -> some View {
        switch block.destination {
        case .popular:
            Text("popular")
        case .preferences:
            UserPreferencesView()
        }
    }
    
}
