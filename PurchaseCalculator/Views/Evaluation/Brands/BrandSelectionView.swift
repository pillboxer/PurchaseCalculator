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
    var isAddingYourOwn: Bool = false
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
    
    private var header: String {
        let base = "brands_header"
        return isAddingYourOwn ? base.appending("_add_your_own") : base
    }
    
    @ViewBuilder
    private var destination: some View {
        if isAddingYourOwn, let item = item {
            CustomUnitCreationView(item: item, initialBrandName: selectedBrand?.handle ?? "", isActive: $isActive)
        }
        else {
            EvaluationUnitSelectionView(units: units, isActive: $isActive)
            
        }
    }
    
    var body: some View {
        HiddenNavigationLink(destination: destination, isActive: $isPushed)
        EmptorColorSchemeAdaptingView {
            VStack {
                if isAddingYourOwn {
                    CTAButton(text: "custom_brand_cta", width: 150) {
                        isPushed = true
                    }
                    .padding()
                }
                BasicGridSelectionView(header: header) {
                    ForEach(brands) { brand in
                        CTAButton(text: brand.handle, imageWrapper: ImageWrapper(name: brand.imageName), animationPeriod: nil) {
                            selectedBrand = brand
                            isPushed = true
                        }
                    }
                }
            }

        }
    }
    
}
