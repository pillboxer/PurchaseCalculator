//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

struct HomescreenView: View {
    
    // Observed so we refresh when a user is created
    @ObservedObject var userPreferencesViewModel = UserPreferencesViewModel()
    
    @State private var selectedRow: String?
    
    var homeViewModel = HomeViewModel()
    var purchaseCategoryViewModel = PurchaseCategoriesViewModel()
        
    var categoryView: some View {
        PurchaseCategorySelectionView()
            .environmentObject(purchaseCategoryViewModel)
    }
    
    var preferencesView: some View {
        UserPreferencesView(row: $selectedRow)
            .environmentObject(userPreferencesViewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image(systemName: "e.square")
                    .resizable()
                    .padding()
                    .frame(width: 100, height: 100, alignment: .center)
                if User.doesExist {
                    NavigationLinkedRowView(item: HomeRow(handle: homeViewModel.categoriesTitle, imageName: homeViewModel.categoriesImageString), destinationController: categoryView, selectedID: $selectedRow) {
                        selectedRow = homeViewModel.categoriesTitle
                    }
                }
                NavigationLinkedRowView(item: HomeRow(handle: homeViewModel.preferencesRowTitle, imageName: homeViewModel.preferencesImageString), destinationController: preferencesView, selectedID: $selectedRow) {
                    selectedRow = homeViewModel.preferencesRowTitle
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeRow: RowType {
    
    var handle: String
    var imageName: String
    
    var uuid: String {
        handle
    }
}
