//
//  PurchaseItemSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI

struct PurchaseItemSelectionView: View {
    
    @EnvironmentObject var model: PurchaseEvaluationViewModel
    
    var items: [PurchaseItem]?
    
    var body: some View {
        if let items = items {
            List(items) { item in
                NavigationLink(destination: PurchaseItemDetailsView(item: item)
                                .environmentObject(model)) {
                    Text(item.itemHandle)
                }
            }

        }
        else {
            Text("No items to show")
        }

    }
    
}
