//
//  NewUserManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import Combine
import SystemKit

class NewUserViewModel: ObservableObject, ErrorPublisher {
    
    // MARK: - Errors
    enum NewUserViewModelAlertMessage: String {
        case takeHomePayNotANumber = "Please ensure your take home pay is a number"
    }
    
    var currentAlertMessage = "" {
        didSet {
            showAlert = true
        }
    }
    var showAlert: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    var currentErrorMessage: String?
    
    
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
    
    // MARK: - Initialisation
    init() {
        _ = valuesQuestionnaire
    }
    
    // MARK: - Values
    var purchaseAttributesToWeightsMap: [String:Double] = [:]
    
    lazy var valuesQuestionnaire: [Question]? = {
        do {
            let questions = try JSONDecoder.decodeLocalJSON(file: "PurchaseAttributeValueQuestions", type: [Question].self)
            for question in questions {
                if let id = question.attributeID {
                    purchaseAttributesToWeightsMap[id] = 0.5
                }
            }
            return questions
        }
        catch let error {
            publishErrorMessage(error)
            return nil
        }
    }()
    
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
    
    // MARK: - Validation
    var formIsValid: Bool {
        if Double(newUserTakeHomePay) == nil {
            currentAlertMessage = NewUserViewModelAlertMessage.takeHomePayNotANumber.rawValue
            return false
        }
        return !newUserName.isEmpty && !newUserTakeHomePay.isEmpty
    }
}
