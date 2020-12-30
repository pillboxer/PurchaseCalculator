//
//  PurchaseItemSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI
import PurchaseCalculatorDataKit

struct PurchaseItemSelectionView: FirebaseRefreshingView {
    
    @ObservedObject var firebaseObserved: FirebaseCoordinator = FirebaseCoordinator.shared
    @State private var selectedItemID: String?
    var items: [PurchaseItem]?
    
    var body: some View {
        if let items = items {
            let list = PurchaseItemsListView(items: items,
                                             selectedItemID: $selectedItemID)
            BasicNavigationView {
                ListContainerView(headerText: "Now select the specific product you want to evaluate",
                                  list: list)
            }

        }
        else {
            BasicNavigationView {
                Label("No items")
            }
        }
        
    }
    
}

struct PurchaseItemsListView: View {
    
    var items: [PurchaseItem]
    @Binding var selectedItemID: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items) { item in
                    let model = PurchaseItemViewModel(item: item)
                    let destination = PurchaseItemDetailsView()
                        .environmentObject(model)
                    NavigationLinkedRowView(item: item,
                                            destinationController: destination,
                                            selectedID: $selectedItemID) {
                        selectedItemID = item.id
                    }
                }
            }
        }
    }
}
