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
        "profile" 
    }
    
    var categoriesTitle: String {
        "Evaluate A Product"
    }
    
    var categoriesImageString: String {
        "calculate"
    }
    
    var hidesCategoriesRow: Bool {
        user == nil
    }
    
}
