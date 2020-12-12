//
//  PurchaseItemDetailsView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import SwiftUI

struct PurchaseItemDetailsView: View {
    
    @ObservedObject var evaluationManager: EvaluationManager
    @ObservedObject var model: PurchaseItemViewModel
    
    var item: PurchaseItem {
        model.item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            BackButtonView()
            let list = PurchaseItemBrandSelectionView(model: model)
            ListContainerView(headerText: "\(item.title) brand", list: list)
        }
    }
}

struct PurchaseItemBrandSelectionView: View {
    
    @ObservedObject var model: PurchaseItemViewModel
    
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
