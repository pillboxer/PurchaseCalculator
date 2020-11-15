//
//  User+CoreDataClass.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    static var existingUser: User? {
        let request: NSFetchRequest<User> = self.fetchRequest()
        let context = CoreDataManager.shared.moc
        return try? context.fetch(request).first
    }
    
    static var doesExist: Bool {
        existingUser != nil
    }
    
    var purchaseValuesArray: [PurchaseAttributeValue]? {
        purchaseValues?.allObjects as? [PurchaseAttributeValue]
    }


}
