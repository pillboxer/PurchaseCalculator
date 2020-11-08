//
//  CoreDataManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
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
        
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    
}

extension NSManagedObject {
    
    static func deleteAll() {
        if let entityName = NSStringFromClass(self).components(separatedBy: ".").last {
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            try? CoreDataManager.shared.moc.execute(deleteRequest)
        }
    }

}
