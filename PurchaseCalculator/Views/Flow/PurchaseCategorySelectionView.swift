//
//  PurchaseCategorySelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 19/11/2020.
//

import SwiftUI
import PurchaseCalculatorDataKit

struct PurchaseCategorySelectionView: FirebaseRefreshingView {

    @StateObject var firebaseObserved: FirebaseCoordinator = FirebaseCoordinator.shared
    @EnvironmentObject var model: PurchaseCategoriesViewModel
    
    var body: some View {
        if let error = model.currentErrorMessage {
            Label(error)
        }
        else if let categories = model.purchaseCategories {
            let list = PurchaseCategoriesListView(categories: categories)
            BasicNavigationView(home: true) {
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
                    let destination = PurchaseItemSelectionView(items: model.itemsForCategory(category))
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

