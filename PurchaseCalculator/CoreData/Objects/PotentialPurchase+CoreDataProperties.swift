//
//  PotentialPurchase+CoreDataProperties.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/11/2020.
//
//

import Foundation
import CoreData


extension PotentialPurchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PotentialPurchase> {
        return NSFetchRequest<PotentialPurchase>(entityName: "PotentialPurchase")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var resultAdvice: String?
    @NSManaged public var title: String?

}

extension PotentialPurchase : Identifiable {

}
