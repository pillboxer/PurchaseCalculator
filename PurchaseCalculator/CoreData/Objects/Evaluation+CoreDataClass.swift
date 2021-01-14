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
public class Evaluation: NSManagedObject {
    
    class var allInstances: [Evaluation] {
        let request: NSFetchRequest<Evaluation> = self.fetchRequest()
        let context = CoreDataManager.shared.moc
        return (try? context.fetch(request)) ?? []
    }
    
    class func createWith(itemName: String, unitCost: Double, score: Double, attributeEvaluations: [AttributeEvaluation], penaltyApplied: Bool, in context: NSManagedObjectContext = CoreDataManager.shared.moc) -> Evaluation {
        let evaluation = Evaluation(context: context)
        evaluation.itemName = itemName
        evaluation.unitCost = unitCost
        evaluation.score = score
        attributeEvaluations.forEach { evaluation.addToAttributeEvaluations($0)  }
        evaluation.penaltyApplied = penaltyApplied
        return evaluation
    }
    
}
