//
//  PurchaseItemSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI

struct PurchaseItemSelectionView: View {
    
    @State var selectedItemID: String?
    var items: [PurchaseItem]?
    
    var body: some View {
        if let items = items,
           let user = User.existingUser,
           let evaluationManager = EvaluationManager(user: user) {
            let list = PurchaseItemsListView(items: items,
                                             manager: evaluationManager,
                                             selectedItemID: $selectedItemID)
            VStack(alignment: .leading) {
                BackButtonView()
                ListContainerView(headerText: "Now select the specific product you want to evaluate",
                                  list: list)
            }
        }
        else {
            // FIXME
            Text("No items to show")
        }
        
    }
    
}

struct PurchaseItemsListView: View {
    
    var items: [PurchaseItem]
    var manager: EvaluationManager
    @Binding var selectedItemID: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items) { item in
                    let model = PurchaseItemViewModel(item: item)
                    let destination = PurchaseItemDetailsView(evaluationManager: manager, model: model).navigationBarHidden(true)
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
