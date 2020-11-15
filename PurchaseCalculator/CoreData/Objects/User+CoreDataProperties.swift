//
//  User+CoreDataProperties.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var purchaseValues: NSSet?
    @NSManaged public var name: String?
    @NSManaged public var takeHomePay: NSNumber?

}

// MARK: Generated accessors for purchaseValues
extension User {

    @objc(addPurchaseValuesObject:)
    @NSManaged public func addToPurchaseValues(_ value: PurchaseAttributeValue)

    @objc(removePurchaseValuesObject:)
    @NSManaged public func removeFromPurchaseValues(_ value: PurchaseAttributeValue)

    @objc(addPurchaseValues:)
    @NSManaged public func addToPurchaseValues(_ values: NSSet)

    @objc(removePurchaseValues:)
    @NSManaged public func removeFromPurchaseValues(_ values: NSSet)

}

extension User : Identifiable {

}
