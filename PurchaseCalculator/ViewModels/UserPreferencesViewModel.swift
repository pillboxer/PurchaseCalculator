//
//  UserPreferencesViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import Combine
import SystemKit
import UIKit

class UserPreferencesViewModel: ObservableObject, ErrorPublisher {

    var currentErrorMessage: String?
    
    lazy var user: User = {
         User.existingUser ?? User(context: CoreDataManager.shared.moc)
    }()
    
    // MARK: - Published
    @Published var showAlert: Bool = false
    
    // MARK: - Name
    var minimumCharactersInName = 3
    var maximumCharactersInName = 15
    
    var userName = "" {
        didSet {
            userName = String(userName.prefix(maximumCharactersInName))
            updateUserName()
            objectWillChange.send()
        }
    }
    
    private func updateUserName() {
        user.name = userName
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
            updateUserTakeHomePay()
            objectWillChange.send()
        }
    }
    
    private func updateUserTakeHomePay() {
        guard userTakeHomePayNumber != 0 else {
            userTakeHomePay = ""
            user.takeHomePay = nil
            return
        }
        user.takeHomePay = NSNumber(integerLiteral: userTakeHomePayNumber)
    }
    
    var userTakeHomePayNumber: Int {
        Int(userTakeHomePay.dropFirst()) ?? 0
    }

    // MARK: - Curency
    var selectedCurrency: Currency = .GBP {
        didSet {
            user.selectedCurrency = selectedCurrency
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
        initialiseTakeHomePay()
        userName = user.name ?? ""
    }
    
    private func initialiseTakeHomePay() {
        if let takeHomePay = user.takeHomePay?.intValue {
            userTakeHomePay = String(takeHomePay)
        }
        else {
            userTakeHomePay = ""
        }
    }
    
    // MARK: - Values
    func addAttributeValue(id: String?, weight: Double) {
        guard let id = id else {
            return
        }
        user.addWeightForAttributeID(id, weight: weight)
    }
    
    func weightForValue(id: String?) -> Double {
        guard let id = id else {
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
    func save() {
        let manager = CoreDataManager.shared
        let context = manager.moc
        manager.save(context) { error in
            if let error = error {
                self.publishErrorMessage(error)
            }
        }
        self.objectWillChange.send()
    }

}
