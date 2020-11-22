//
//  PurchaseHelper.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 22/11/2020.
//

import Foundation

class PurchaseHelper {
    
    private static var existingUsersPurchaseValues: [PurchaseAttributeValue]? {
        User.existingUser?.purchaseValuesArray
    }
    
    static func attributeNameForUUID(_ uuid: String) -> String {
        let attributes = try? JSONDecoder.decodeLocalJSON(file: "PurchaseAttributes", type: [PurchaseAttribute].self)
        return attributes?.filter { $0.uuid == uuid }.first?.handle ?? uuid
    }
    
    static func usersPurchaseAttributeValueWeightForAttributeID(_ id: String) -> Double {
        existingUsersPurchaseValues?.filter { $0.attributeID == id }.first?.weight ?? 0.5
    }
    
    static func isGreaterThan5PerCentOfTakeHomePay(_ amount: Double) -> Bool {
        guard let takeHomePay = User.existingUser?.takeHomePay?.doubleValue else {
            return false
        }
        let fivePerCentOfTakeHomePay = takeHomePay * 0.05
        return amount > fivePerCentOfTakeHomePay
    }
}
