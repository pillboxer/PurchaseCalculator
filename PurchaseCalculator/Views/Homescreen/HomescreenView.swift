//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

protocol Presenter: View {
    associatedtype Presented: View
    var presentee: Presented { get }
    var presenting: Bool { get set }
}

struct HomescreenView: View {
    
    @ObservedObject var coreDataManager = CoreDataManager.shared
    private var blockHelper = HomescreenBlockHelper()
    var homeViewModel = HomeViewModel()
    @State private var isSelected = false
    var purchaseCategoryViewModel = PurchaseCategoriesViewModel()
        
    var categoryView: some View {
        PurchaseCategorySelectionView()
            .environmentObject(purchaseCategoryViewModel)
    }
    
    var body: some View {
        if !User.doesExist {
            NoUserHomescreen()
        }
        else {
            VStack {
                ForEach(DecodedObjectProvider.homescreenBlockContainers ?? [], id: \.uuid) { container in
                    blockHelper.blockView(for: container) {
//                        blockHelper.selectedBlock = block
//                        isSelected = true
                    }
                    .fullScreenCover(isPresented: $isSelected, content: {
//                        blockHelper.view()
                    })
                    .padding()
                }
            }

        }
    }

}
struct HomeRow: RowType {
    
    var handle: String
    var imageName: String
    
    var uuid: String {
        handle
    }
}
