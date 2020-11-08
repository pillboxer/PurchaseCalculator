//
//  PurchaseAttributeValue+CoreDataProperties.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//
//

import Foundation
import CoreData


extension PurchaseAttributeValue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseAttributeValue> {
        return NSFetchRequest<PurchaseAttributeValue>(entityName: "PurchaseAttributeValue")
    }

    @NSManaged public var attributeID: String?
    @NSManaged public var weight: Double
    @NSManaged public var user: User?

}

extension PurchaseAttributeValue : Identifiable {

}
