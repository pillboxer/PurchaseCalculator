//
//  AttributeEvaluation+CoreDataProperties.swift
//  
//
//  Created by Henry Cooper on 14/01/2021.
//
//

import Foundation
import CoreData


extension AttributeEvaluation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AttributeEvaluation> {
        return NSFetchRequest<AttributeEvaluation>(entityName: "AttributeEvaluation")
    }

    @NSManaged public var attributeName: String
    @NSManaged public var attributeScore: Double
    @NSManaged public var attributeImageName: String
    @NSManaged public var userWeightingScore: Double

}
