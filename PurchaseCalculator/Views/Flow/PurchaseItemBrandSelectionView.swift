//
//  PurchaseItemBrandSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 24/12/2020.
//

import SwiftUI
import PurchaseCalculatorDataKit

struct PurchaseItemBrandSelectionView: FirebaseRefreshingView {
    
    @ObservedObject var firebaseObserved: FirebaseCoordinator = FirebaseCoordinator.shared
    @EnvironmentObject var model: PurchaseItemViewModel
    @EnvironmentObject var evaluationManager: EvaluationManager
    
    var brands: [PurchaseBrand] {
        return model.brands
    }
    
    @State var brandSelection: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(brands) { brand in
                    let viewModel = SpecificPurchaseUnitSelectionViewModel(units: model.unitsForBrand(brand))
                    let destination = SpecificPurchaseUnitSelectionView(viewModel: viewModel)
                        .environmentObject(evaluationManager)
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
