//
//  NewUserManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import Combine
import SystemKit

class NewUserViewModel: ObservableObject {
    
    // MARK: - Publishing
    let objectWillChange = ObservableObjectPublisher()
    
    // MARK: - Errors
    enum NewUserViewModelAlertMessage: String {
        case takeHomePayNotANumber = "Please ensure your take home pay is a number"
    }
    
    var currentAlertMessage = ""
    var showAlert: Bool = false {
        didSet {
            if showAlert == false {
                currentAlertMessage = ""
            }
            objectWillChange.send()
        }
    }
    
    var currentErrorMessage: String? {
        didSet {
            objectWillChange.send()
        }
    }
    private func publishErrorMessage(_ error: Error) {
        currentErrorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
    }
    
    // MARK: - Name
    var minimumCharactersInName = 3
    var maximumCharactersInName = 15
    
    var newUserName = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    // MARK: - Pay
    var maximumDigitsForTakeHomePay = 8
    var minimumDigitsForTakeHomePay = 3
    var selectedCurrency: Currency = .GBP {
        didSet {
            objectWillChange.send()
        }
    }
    
    var selectedCurrencyString: String {
        get {
            return selectedCurrency.rawValue
        }
        set {
            selectedCurrency = Currency(rawValue: newValue) ?? .GBP
        }
    }
    
    var newUserTakeHomePay = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    var currencies: [Currency] {
        Currency.allCases
    }
    
    // MARK: - Values
    var purchaseAttributesToWeightsMap: [String:Double] = [:]
    
    var valuesQuestionnaire: [Question]? {
        do {
            let questions = try JSONDecoder.decodeLocalJSON(file: "PurchaseAttributeValueQuestions", type: [Question].self)
            return questions
        }
        catch let error {
            publishErrorMessage(error)
            return nil
        }
    }
    
    // MARK: - Saving
    func saveNewUser() {
        guard formIsValid else {
            return
        }
        let context = CoreDataManager.shared.moc
        let user = User(context: context)
        user.name = newUserName
        for attribute in purchaseAttributesToWeightsMap {
            let newValue = PurchaseAttributeValue(context: context)
            newValue.attributeID = attribute.key
            newValue.weight = attribute.value
            let takeHomePay = Double(newUserTakeHomePay) ?? 0
            user.takeHomePay = NSNumber(floatLiteral: takeHomePay)
            user.addToPurchaseValues(newValue)
        }
        if let error = context.saveWithTry() {
            publishErrorMessage(error)
            context.reset()
        }
        else {
            objectWillChange.send()
        }
    }
    
    var formIsValid: Bool {
        guard let _ = Double(newUserTakeHomePay) else {
            currentAlertMessage = NewUserViewModelAlertMessage.takeHomePayNotANumber.rawValue
            showAlert = true
            return false
        }
        return true
    }
}
