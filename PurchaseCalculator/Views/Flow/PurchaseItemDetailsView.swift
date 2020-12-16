//
//  PurchaseItemDetailsView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI

struct PurchaseItemDetailsView: View {
    
    @EnvironmentObject var model: PurchaseItemViewModel
    
    var item: PurchaseItem {
        model.item
    }
        
    var body: some View {
        VStack(alignment: .leading) {
            BackButtonView()
            let list = PurchaseItemBrandSelectionView()
            ListContainerView(headerText: "\(item.title) brand", list: list)
        }
    }
}

struct PurchaseItemBrandSelectionView: FirebaseRefreshingView {
    
    @ObservedObject var firebaseObserved: FirebaseManager = FirebaseManager.shared
    @EnvironmentObject var model: PurchaseItemViewModel
    
    var brands: [PurchaseBrand] {
        return model.brands
    }
    
    @State var brandSelection: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(brands) { brand in
                    let destination = SpecificPurchaseUnitSelectionView(units: model.unitsForBrand(brand))
                    NavigationLinkedRowView(item: brand,
                                            destinationController: destination,
                                            selectedID: $brandSelection) {
                        brandSelection = brand.id
                    }
                }
            }
        }
    }
}
