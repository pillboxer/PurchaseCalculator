//
//  PurchaseItemSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 23/01/2021.
//

import SwiftUI

struct ItemSelectionView: View {
    
    @State private var selectedItem: PurchaseItem?
    @Binding var isActive: Bool
    @State var isPushed = false
    
    var items: [PurchaseItem] {
        let unsorted = DecodedObjectProvider.purchaseItems?.filter { $0.specificPurchaseUnits != nil } ?? []
        return unsorted.sorted { $0.handle < $1.handle }
    }
    
    var units: [SpecificPurchaseUnit] {
        selectedItem?.specificPurchaseUnits?.sorted { unit1, unit2 in
            if unit1.brandHandle == unit2.brandHandle {
                return unit1.modelName < unit2.modelName
            }
            return unit1.brandHandle < unit2.brandHandle
        } ?? []
    }
    
    @ViewBuilder
    private var destination: some View {
        BrandSelectionView(isActive: $isActive, item: selectedItem)
    }
    
    var body: some View {
        HiddenNavigationLink(destination: destination, isActive: $isPushed)
        BasicGridSelectionView(header: "items_header") {
            ForEach(items) { item in
                CTAButton(text: item.handle, imageWrapper: ImageWrapper(name: item.imageName, renderingMode: .original), animationPeriod: nil) {
                    selectedItem = item
                    isPushed = true
                }
            }
        }
    }
    
}

