//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    @ObservedObject var userPreferencesViewModel = UserPreferencesViewModel()
    @ObservedObject var purchaseCategoryViewModel = PurchaseCategoriesViewModel()
    
    @State var selectedRow: String?
        
    var categoryView: some View {
        PurchaseCategorySelectionView()
            .environmentObject(purchaseCategoryViewModel)
            .navigationBarHidden(true)
    }
    
    var preferencesView: some View {
        UserPreferencesView(row: $selectedRow)
            .environmentObject(userPreferencesViewModel)
            .navigationBarHidden(true)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image(systemName: "e.square")
                    .resizable()
                    .padding()
                    .frame(width: 100, height: 100, alignment: .center)
                if User.doesExist {
                    NavigationLinkedRowView(item: HomeRow(title: homeViewModel.categoriesTitle, imageName: homeViewModel.categoriesImageString), destinationController: categoryView, selectedID: $selectedRow) {
                        selectedRow = homeViewModel.categoriesTitle
                    }
                }
                NavigationLinkedRowView(item: HomeRow(title: homeViewModel.preferencesRowTitle, imageName: homeViewModel.preferencesImageString), destinationController: preferencesView, selectedID: $selectedRow) {
                    selectedRow = homeViewModel.preferencesRowTitle
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeRow: RowType {
    
    var id: String {
        title
    }

    var title: String
    var imageName: String
}
