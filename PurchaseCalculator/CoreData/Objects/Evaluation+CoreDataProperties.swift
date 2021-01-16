//
//  Evaluation+CoreDataProperties.swift
//  
//
//  Created by Henry Cooper on 14/01/2021.
//
//

import Foundation
import CoreData


extension Evaluation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Evaluation> {
        return NSFetchRequest<Evaluation>(entityName: "Evaluation")
    }

    @NSManaged public var itemName: String
    @NSManaged public var unitName: String
    @NSManaged public var unitCost: Double
    @NSManaged public var score: Double
    @NSManaged public var penaltyApplied: Bool
    @NSManaged public var attributeEvaluations: NSSet
    @NSManaged public var dateCreated: Double

}

// MARK: Generated accessors for attributeEvaluations
extension Evaluation {

    @objc(addAttributeEvaluationsObject:)
    @NSManaged public func addToAttributeEvaluations(_ value: AttributeEvaluation)

    @objc(removeAttributeEvaluationsObject:)
    @NSManaged public func removeFromAttributeEvaluations(_ value: AttributeEvaluation)

    @objc(addAttributeEvaluations:)
    @NSManaged public func addToAttributeEvaluations(_ values: NSSet)

    @objc(removeAttributeEvaluations:)
    @NSManaged public func removeFromAttributeEvaluations(_ values: NSSet)

}
