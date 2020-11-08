//
//  NewUserManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import Combine
import SystemKit

class NewUserDataModel: ObservableObject {
    
    @Published var purchaseAttributesToWeightsMap: [String:Double] = [:] {
        didSet {
            print(purchaseAttributesToWeightsMap)
        }
    }
    
   let objectWillChange = ObjectWillChangePublisher()
    
    func saveNewUser() {
        let context = CoreDataManager.shared.moc
        let user = User(context: context)
        for attribute in purchaseAttributesToWeightsMap {
            let newValue = PurchaseAttributeValue(context: context)
            newValue.attributeID = attribute.key
            newValue.weight = attribute.value
            user.addToPurchaseValues(newValue)
        }
        // TODO: - Handle Error
        try! context.save()
        objectWillChange.send()
    }
    
}

// MARK: - Questionnaire
extension NewUserDataModel {
    
    var valuesQuestionnaire: [Question]? {
        do {
            let questions = try JSONDecoder.decodeLocalJSON(file: "PurchaseAttributeValueQuestions", type: [Question].self)
            return questions
        }
        catch let error {
            print((error as? SystemKitError)?.errorDescription)
            return nil
        }
    }

}
