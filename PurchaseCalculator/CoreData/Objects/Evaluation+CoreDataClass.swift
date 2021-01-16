//
//  Evaluation+CoreDataClass.swift
//  
//
//  Created by Henry Cooper on 14/01/2021.
//
//

import Foundation
import CoreData

@objc(Evaluation)
public class Evaluation: NSManagedObject, Identifiable {
    
    class var allInstances: [Evaluation] {
        let request: NSFetchRequest<Evaluation> = self.fetchRequest()
        let context = CoreDataManager.shared.moc
        return (try? context.fetch(request)) ?? []
    }
    
    class func createWith(itemName: String,
                          unitName: String,
                          unitCost: Double,
                          score: Double,
                          dateCreated: Double,
                          attributeEvaluations: [AttributeEvaluation],
                          penaltyApplied: Bool,
                          in context: NSManagedObjectContext = CoreDataManager.shared.moc) -> Evaluation {
        let evaluation = Evaluation(context: context)
        evaluation.itemName = itemName
        evaluation.unitCost = unitCost
        evaluation.dateCreated = dateCreated
        evaluation.score = score
        attributeEvaluations.forEach { evaluation.addToAttributeEvaluations($0)  }
        evaluation.penaltyApplied = penaltyApplied
        evaluation.unitName = unitName
        return evaluation
    }
}
