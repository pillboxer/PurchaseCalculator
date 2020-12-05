//
//  CoreDataManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import CoreData

class CoreDataManager {
        
    // MARK: - Enums
    enum CoreDataError: LocalizedError {
        case entityDoesNotExist
    }
    
    // MARK: - Exposed
    static var shared: CoreDataManager = CoreDataManager()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Properties
    @EphemeralConsidered<String>(ephemeral: NSInMemoryStoreType, notEphemeral: NSSQLiteStoreType)
    private var storeType
    
    private var model: NSManagedObjectModel {
        guard let modelURL = Bundle.main.url(forResource: "PurchaseCalculatorDataModel", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Could Not Create Model")
        }
        return model
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PurchaseCalculatorDataModel", managedObjectModel: model)
        if let url = container.persistentStoreDescriptions.last?.url {
            let description = NSPersistentStoreDescription(url: url)
            description.type = storeType
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Could Not Load Persistent Container")
            }
        }
        return container
    }()
    
    // MARK: - Saving
    func save(_ context: NSManagedObjectContext, completion: ((Error?) -> Void)? = nil) {
        context.perform {
            do {
                try context.save()
                completion?(nil)
            }
            catch let error {
                context.reset()
                completion?(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func saveSynchronously(_ context: NSManagedObjectContext, completion: ((Error?) -> Void)? = nil) {
        context.performAndWait {
            do {
                try context.save()
                completion?(nil)
            }
            catch let error {
                context.reset()
                completion?(error)
                print(error.localizedDescription)
            }
        }
    }
}

extension NSManagedObject {
    
    @discardableResult static func deleteAll(_ context: NSManagedObjectContext) -> Error? {
        if let entityName = NSStringFromClass(self).components(separatedBy: ".").last {
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            do {
                try context.execute(deleteRequest)
            }
            catch let error {
                return error
            }
        }
        return CoreDataManager.CoreDataError.entityDoesNotExist
    }
}
