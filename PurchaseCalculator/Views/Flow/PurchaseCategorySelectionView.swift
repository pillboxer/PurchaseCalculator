//
//  PurchaseCategorySelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 19/11/2020.
//

import SwiftUI
import SystemKit

struct PurchaseCategorySelectionView: FirebaseRefreshingView {

    @ObservedObject var firebaseObserved: FirebaseManager = FirebaseManager.shared
    @EnvironmentObject var model: PurchaseCategoriesViewModel
    
    var body: some View {
        if let error = model.currentErrorMessage {
            Text(error)
        }
        else if let categories = model.purchaseCategories {
            let list = PurchaseCategoriesListView(categories: categories)
            VStack(alignment: .leading) {
                HomeButtonView()
                ListContainerView(headerText: model.listHeaderTitle,
                                  list: list)
            }
        }
    }
}

struct PurchaseCategoriesListView: View {
    
    @EnvironmentObject var model: PurchaseCategoriesViewModel
    @State private var selectedCategoryID: String?

    let categories: [PurchaseCategory]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(categories) { category in
                    let destination = PurchaseItemSelectionView(items: model.itemsForCategory(category)).navigationBarHidden(true)
                    NavigationLinkedRowView(item: category,
                                            destinationController: destination,
                                            selectedID: $selectedCategoryID) {
                        selectedCategoryID = category.id
                    }
                }
            }
        }
    }
}

