//
//  BrandSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 16/01/2021.
//

import SwiftUI

struct BrandSelectionView: View {

    @State private var selectedBrand: PurchaseBrand?
    @Binding var isActive: Bool
    @State var isPushed = false
    var item: PurchaseItem?
    
    var brands: [PurchaseBrand] {
        let brandsToSort = item?.brands ?? DecodedObjectProvider.allSpecificPurchaseUnits?.compactMap { $0.brand } ?? []
        let unsorted = Set(brandsToSort)
        return unsorted.sorted { $0.handle < $1.handle }

    }
    
    var units: [SpecificPurchaseUnit] {
        let allUnits = selectedBrand?.units?.sorted { $0.modelName < $1.modelName } ?? []
        if let item = item {
            return allUnits.filter { $0.item == item }
        }
        return allUnits
    }
    
    @ViewBuilder
    private var destination: some View {
        EvaluationUnitSelectionView(units: units, isActive: $isActive)
    }
    
    var body: some View {
        HiddenNavigationLink(destination: destination, isActive: $isPushed)
        BasicGridSelectionView(header: "brands_header") {
            ForEach(brands) { brand in
                CTAButton(text: brand.handle, imageWrapper: ImageWrapper(name: brand.imageName, renderingMode: .template), animationPeriod: nil) {
                    selectedBrand = brand
                    isPushed = true
                }
            }
        }
    }
    
}
