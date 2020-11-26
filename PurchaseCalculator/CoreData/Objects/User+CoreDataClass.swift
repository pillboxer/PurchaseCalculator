//
//  User+CoreDataClass.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    static var existingUser: User? {
        let request: NSFetchRequest<User> = self.fetchRequest()
        let context = CoreDataManager.shared.moc
        return try? context.fetch(request).first
    }
    
    static var doesExist: Bool {
        existingUser != nil
    }
    
    var purchaseValuesArray: [PurchaseAttributeValue]? {
        purchaseValues?.allObjects as? [PurchaseAttributeValue]
    }

    var selectedCurrency: Currency {
        get {
            return Currency(rawValue: selectedCurrencyString ?? "GBP") ?? .GBP
        }
        set {
            selectedCurrencyString = newValue.rawValue
        }
    }
    
    func weightForAttributeID(_ id: String) -> Double? {
        purchaseValuesArray?.filter { $0.attributeID == id }.first?.weight
    }
    
    func amountAsPerCentOfTakeHomePay(_ amount: Double) -> Double {
        guard let takeHomePay = takeHomePay?.doubleValue else {
            return 0
        }
        return amount / takeHomePay * 100
    }

}
