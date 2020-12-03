//
//  NewUserManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import Combine
import SystemKit
import UIKit

class NewUserViewModel: ObservableObject, ErrorPublisher {
    
    // MARK: - Published
    @Published var showAlert: Bool = false
    
    var newUserName = "" {
        didSet {
            newUserName = String(newUserName.prefix(maximumCharactersInName))
            objectWillChange.send()
        }
    }
    var newUserTakeHomePay = "" {
        didSet {
            let first = newUserTakeHomePay.contains(selectedCurrencyString) ? "" : selectedCurrencyString
            let beforeClip = newUserTakeHomePay.isEmpty ? newUserTakeHomePay : first + newUserTakeHomePay
            newUserTakeHomePay = String(beforeClip.prefix(maximumDigitsForTakeHomePay))
            if newUserTakeHomePayNumber.isZero { newUserTakeHomePay = ""}
            objectWillChange.send()
        }
    }
    
    var newUserTakeHomePayNumber: Double {
        Double(newUserTakeHomePay.dropFirst()) ?? 0
    }
    
    // MARK: - Errors
    enum NewUserViewModelAlertMessage: String {
        case takeHomePayZero = "Please ensure your take home pay is more than zero"
    }
    
    var currentAlertMessage = "" {
        didSet {
            showAlert = true
        }
    }
    
    var currentErrorMessage: String?
    
    // MARK: - Name
    var minimumCharactersInName = 3
    var maximumCharactersInName = 15
    
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
            return selectedCurrency.symbol
        }
        set {
            let currency = Currency.currencyForSymbol(newValue)
            selectedCurrency = Currency.currencyForSymbol(newValue)
            newUserTakeHomePay = newUserTakeHomePay.isEmpty ? newUserTakeHomePay : currency.symbol + String(Int(newUserTakeHomePayNumber))
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
        let manager = CoreDataManager.shared
        let context = manager.moc
        let user = User(context: context)
        user.name = newUserName
        for attribute in purchaseAttributesToWeightsMap {
            let newValue = PurchaseAttributeValue(context: context)
            newValue.attributeID = attribute.key
            newValue.weight = attribute.value
            let takeHomePay = newUserTakeHomePayNumber
            user.takeHomePay = NSNumber(floatLiteral: takeHomePay)
            user.selectedCurrency = selectedCurrency
            user.addToPurchaseValues(newValue)
        }
        manager.save(context) { error in
            if let error = error {
                self.publishErrorMessage(error)
            }
        }
        self.objectWillChange.send()
    }
    
    // MARK: - Validation
    var formIsValid: Bool {
        if newUserTakeHomePayNumber.isZero {
            currentAlertMessage = NewUserViewModelAlertMessage.takeHomePayZero.rawValue
            return false
        }
        return !newUserName.isEmpty && !newUserTakeHomePay.isEmpty
    }
}
