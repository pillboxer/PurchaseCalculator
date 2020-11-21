//
//  PurchaseCategorySelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 19/11/2020.
//

import SwiftUI

struct PurchaseCategorySelectionView: View {
    @EnvironmentObject var model: PurchaseCategorySelectionViewModel
    var body: some View {
        if let error = model.currentErrorMessage {
            Text(error)
        }
        else if let categories = model.purchaseCategories {
            List(categories) { category in
                Text(category.categoryHandle)
            }
            .navigationBarTitle("Purchase Category", displayMode: .inline)
        }
    }
}

struct PurchaseCategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseCategorySelectionView()
    }
}
