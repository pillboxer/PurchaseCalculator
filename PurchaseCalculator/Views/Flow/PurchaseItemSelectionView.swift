//
//  PurchaseItemSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI

struct PurchaseItemSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: PurchaseEvaluationViewModel

    @State var selectedItemID: String?
    var items: [PurchaseItem]?
    
    var body: some View {
        if let items = items,
           let user = User.existingUser,
           let evaluationManager = EvaluationManager(user: user) {
            let list = PurchaseItemsListView(items: items,
                                             manager: evaluationManager,
                                             selectedItemID: $selectedItemID)
            ListContainerView(headerText: "What item do you want to evaluate today?",
                              list: list)
        }
        else {
            // FIXME
            Text("No items to show")
        }
        
    }
    
}

struct PurchaseItemsListView: View {
    
    @EnvironmentObject var model: PurchaseEvaluationViewModel
    var items: [PurchaseItem]
    var manager: EvaluationManager
    @Binding var selectedItemID: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items) { item in
                    let destination = PurchaseItemDetailsView(evaluationManager: manager,
                                                              item: item)
                        .environmentObject(model)
                    NavigationLinkedRowView(item: item,
                                       destinationController: destination,
                                       animated: false,
                                       selectedID: $selectedItemID) {
                        selectedItemID = item.id
                        model.allowAnimation = true
                    }
                }
            }
        }
    }
    
}
