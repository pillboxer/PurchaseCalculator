//
//  PurchaseCategorySelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 19/11/2020.
//

import SwiftUI

struct PurchaseCategorySelectionView: View {
    @EnvironmentObject var model: PurchaseEvaluationViewModel
    
    var body: some View {
        if let error = model.currentErrorMessage {
            Text(error)
        }
        else if let categories = model.purchaseCategories {
            let list = PurchaseCategoriesListView(categories: categories)
            ListContainerView(headerText: "Choose the category of the product you want to evalulate",
                              list: list)
                .navigationBarTitle("Purchase Category", displayMode: .inline)
        }
    }
}

struct PurchaseCategoriesListView: View {
    
    @EnvironmentObject var model: PurchaseEvaluationViewModel
    
    let categories: [PurchaseCategory]
    @State var selectedCategoryID: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(categories) { category in
                    let destination = PurchaseItemSelectionView(items: model.itemsForCategory(category))
                        .environmentObject(model)
                    NavigationLinkedRowView(item: category,
                                            destinationController: destination,
                                            animated: model.allowAnimation,
                                            selectedID: $selectedCategoryID) {
                        selectedCategoryID = category.id
                        model.allowAnimation = true
                    }
                }
            }
        }
    }
    
}

