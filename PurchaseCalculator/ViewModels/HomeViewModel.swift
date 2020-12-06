//
//  HomeViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 05/12/2020.
//

import Foundation

class HomeViewModel: ObservableObject {

    // MARK: - Computed Properties
    var user: User? {
        User.existingUser
    }

    var preferencesRowTitle: String {
        user == nil ? "Create New Profile" : "Edit Your Profile"
    }
    
    var preferencesImageString: String {
        user == nil ? "person" : "gear"
    }
    
    var categoriesTitle: String {
        "Evaluate A Product"
    }
    
    var categoriesImageString: String {
        "cursorarrow"
    }
    
    var hidesCategoriesRow: Bool {
        user == nil
    }
    
}
