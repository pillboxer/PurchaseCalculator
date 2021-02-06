//
//  PurchaseItemSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 23/01/2021.
//

import SwiftUI

struct ItemSelectionView: View {
    
    @Binding var isActive: Bool
    var isAddingYourOwn: Bool = false
    
    @State private var selectedItem: PurchaseItem?
    @State private var isPushed = false
    
    var items: [PurchaseItem] {
        let unsorted = DecodedObjectProvider.purchaseItems?.filter { $0.specificPurchaseUnits != nil } ?? []
        return unsorted.sorted { $0.handle < $1.handle }
    }
     
    @ViewBuilder
    private var destination: some View {
        BrandSelectionView(isActive: $isActive, item: selectedItem, isAddingYourOwn: isAddingYourOwn)
    }
    
    var body: some View {
        HiddenNavigationLink(destination: destination, isActive: $isPushed)
        BasicGridSelectionView(header: "items_header") {
            ForEach(items) { item in
                CTAButton(text: item.handle, imageWrapper: ImageWrapper(name: item.imageName), animationPeriod: nil) {
                    selectedItem = item
                    isPushed = true
                }
            }
        }
    }
    
}

