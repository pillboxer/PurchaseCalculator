//
//  UserPreferencesViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import Combine
import SystemKit
import UIKit
import CoreData

class UserPreferencesViewModel: ObservableObject, ErrorPublisher {

    var currentErrorMessage: String?
    
    lazy var context: NSManagedObjectContext = {
        let newContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        newContext.parent = CoreDataManager.shared.moc
        return newContext
    }()
    
    lazy var user: User = {
         return User.existingUser ?? User(context: context)
    }()
    
    // MARK: - Published
    @Published var showAlert: Bool = false
    
    // MARK: - Name
    var minimumCharactersInName = 3
    var maximumCharactersInName = 15
    
    var userName = "" {
        didSet {
            userName = String(userName.prefix(maximumCharactersInName))
            objectWillChange.send()
        }
    }
    
    // MARK: - Pay
    var maximumDigitsForTakeHomePay = 8
    var minimumDigitsForTakeHomePay = 3
    
    var userTakeHomePay = "" {
        didSet {
            guard !userTakeHomePay.isEmpty else {
                // We allow the symbol to be deleted so the placeholder text can be read
                return
            }
            // Get the symbol index and remove the symbol
            let index = userTakeHomePay.firstIndex(of: symbolCharacter)
            userTakeHomePay.safeRemove(at: index)
            // Look at the pay and make sure it is within the max
            let clipped = userTakeHomePay.prefix(maximumDigitsForTakeHomePay)
            userTakeHomePay = String(clipped)
            // Re add the symbol
            userTakeHomePay.insert(symbolCharacter, at: userTakeHomePay.startIndex)
            ensureTakeHomePayIsNonZero()
            objectWillChange.send()
        }
    }
    
    private func ensureTakeHomePayIsNonZero() {
        guard userTakeHomePayNumber != 0 else {
            userTakeHomePay = ""
            return
        }
    }
    
    var userTakeHomePayNumber: Int {
        Int(userTakeHomePay.dropFirst()) ?? 0
    }

    // MARK: - Curency
    var selectedCurrency: Currency {
        get {
            return user.selectedCurrency
        }
        set {
            user.selectedCurrency = newValue
            UIApplication.endEditing()
            objectWillChange.send()

        }
    }
    
    var selectedCurrencyString: String {
        get {
            return selectedCurrency.symbol
        }
        set {
            let currency = Currency.currencyForSymbol(newValue)
            selectedCurrency = currency
            if !userTakeHomePay.isEmpty {
                userTakeHomePay = "\(currency.symbol)\(Int(userTakeHomePayNumber))"
            }
        }
    }
        
    private var symbolCharacter: Character {
        Character(selectedCurrencyString)
    }
    
    var currencies: [Currency] {
        Currency.allCases
    }
    
    // MARK: - Initialisation
    init() {
        _ = valuesQuestionnaire
    }
    
    func setupExistingUserIfNecessary() {
        guard User.doesExist else {
            return
        }
        if let takeHomePay = user.takeHomePay?.intValue {
            userTakeHomePay = String(takeHomePay)
        }
        else {
            userTakeHomePay = ""
        }
        selectedCurrencyString = user.selectedCurrency.symbol
        userName = user.name ?? ""
    }
    
    // MARK: - Values
    func addAttributeValue(id: String?, weight: Double) {
        guard let id = id else {
            return
        }
        UIApplication.endEditing()
        user.addWeightForAttributeID(id, weight: weight)
    }
    
    func weightForValue(id: String?) -> Double {
        guard let id = id, User.doesExist else {
            return 0.5
        }
        return user.weightForAttributeID(id) ?? 0.5
    }
    
    lazy var valuesQuestionnaire: [Question]? = {
        do {
            let questions = try JSONDecoder.decodeLocalJSON(file: "PurchaseAttributeValueQuestions", type: [Question].self)
            return questions
        }
        catch let error {
            publishErrorMessage(error)
            return nil
        }
    }()
    
    // MARK: - Saving
    func save(_ completion: @escaping () -> Void) {
        UIApplication.endEditing()
        user.name = userName
        user.takeHomePay = NSNumber(integerLiteral: userTakeHomePayNumber)
        let manager = CoreDataManager.shared
        manager.save(context) { error in
            if let error = error {
                self.publishErrorMessage(error)
            }
            else {
                completion()
            }
            self.objectWillChange.send()
        }
    }

    func reset() {
        guard !User.doesExist else {
            setupExistingUserIfNecessary()
            return
        }
        userName = ""
        userTakeHomePay = ""
        selectedCurrency = .GBP
    }

}

// MARK: - Strings Provider
extension UserPreferencesViewModel {
    
    var titleString: String {
        "Personalise your results"
    }
    
    var userNameTextFieldPlaceholder: String {
        "Name"
    }
    
    var takeHomePayTextFieldPlaceholder: String {
        "Yearly take home pay"
    }
    
    var listHeaderString: String {
        "What's meaningful to you?"
    }
    
    var saveButtonImageName: String {
        "folder.circle"
    }

}
