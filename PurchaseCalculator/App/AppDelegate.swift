//
//  AppDelegate.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/11/2020.
//

import CoreData
import SwiftUI
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PurchaseCalculatorDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Could Not Load Persistent Container")
            }
        }
        return container
    }()
        
}

// MARK: - Core Data
extension AppDelegate {
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
        
    private func deleteAllPurchases() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PotentialPurchase")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try! persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
    }

}

// MARK: - Other Extensions
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

