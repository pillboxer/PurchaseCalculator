//
//  PurchaseItemDetailsView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI

struct PurchaseItemDetailsView: View {
    
    @EnvironmentObject var model: PurchaseItemViewModel
    var evaluationManager: EvaluationManager
    var item: PurchaseItem {
        model.item
    }
        
    var body: some View {
        BasicNavigationView {
            let list = PurchaseItemBrandSelectionView()
                .environmentObject(evaluationManager)
            ListContainerView(headerText: "\(item.handle) brand", list: list)
        }
    }
}
