//
//  CoreDataManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    enum CoreDataError: LocalizedError {
        case entityDoesNotExist
    }
    
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
    
   @discardableResult static func deleteAll() -> Error? {
        if let entityName = NSStringFromClass(self).components(separatedBy: ".").last {
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            do {
                try CoreDataManager.shared.moc.execute(deleteRequest)
            }
            catch let error {
                return error
            }
        }
        return CoreDataManager.CoreDataError.entityDoesNotExist
    }
}

extension NSManagedObjectContext {
    
    func saveWithTry() -> Error? {
        do {
            try save()
            return nil
        }
        catch let error {
            return error
        }
    }

}
