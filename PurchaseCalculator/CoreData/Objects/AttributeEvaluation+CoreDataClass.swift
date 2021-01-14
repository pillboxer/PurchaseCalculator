//
//  AttributeEvaluation+CoreDataClass.swift
//  
//
//  Created by Henry Cooper on 14/01/2021.
//
//

import Foundation
import CoreData

@objc(AttributeEvaluation)
public class AttributeEvaluation: NSManagedObject {
    
    class func createWith(attributeName: String, attributeScore: Double, attributeImageName: String, userWeightingScore: Double, context: NSManagedObjectContext = CoreDataManager.shared.moc) -> AttributeEvaluation {
        let evaluation = AttributeEvaluation(context: context)
        evaluation.attributeName = attributeName
        evaluation.attributeScore = attributeScore
        evaluation.attributeImageName = attributeImageName
        evaluation.userWeightingScore = userWeightingScore
        return evaluation
    }

}
