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
    var brands: [PurchaseBrand] {
        let unsorted = DecodedObjectProvider.specificPurchaseUnits?.compactMap { $0.brand } ?? []
        return unsorted.sorted { $0.handle < $1.handle }
    }
    
    private let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @ViewBuilder
    private var destination: some View {
        if let selectedBrand = selectedBrand {
            EvaluationUnitSelectionView(units: selectedBrand.units ?? [], isActive: $isActive)
        }
    }
    
    var body: some View {
        BasicNavigationView {
            HiddenNavigationLink(destination: destination, isActive: $isPushed)
            // FIXME: - 
            ListContainerView(headerText: "Brands") {
                LazyVGrid(columns: layout, spacing: 20) {
                    ForEach(brands) { brand in
                        CTAButton(text: brand.handle, imageWrapper: ImageWrapper(name: brand.imageName, renderingMode: .template), animationPeriod: nil) {
                            selectedBrand = brand
                            isPushed = true
                        }
                    }
                }
                .padding()
            }
        }

    }
    
}
