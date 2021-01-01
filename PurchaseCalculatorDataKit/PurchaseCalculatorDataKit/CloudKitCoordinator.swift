//
//  CloudKitCoordinator.swift
//  PurchaseCalculatorDataKit
//
//  Created by Henry Cooper on 31/12/2020.
//

import Foundation
import CloudKit

public class CloudKitCoordinator: NSObject, ObservableObject {
    
    public typealias DictArray = [[String : Any]]
    
    public static let shared = CloudKitCoordinator()
    
    public func updateJSON() {
        PurchaseCalculatorDatabaseChildType.allCases.forEach { updateJSON($0) }
    }
    
    private let db = CKContainer.default().publicCloudDatabase

    
    public func updateJSON(_ type: PurchaseCalculatorDatabaseChildType) {
        let query = CKQuery(recordType: type.cloudKitType, predicate: NSPredicate(value: true))
        db.perform(query, inZoneWith: nil) { (records, error) in
            if let records = records,
               !records.isEmpty {
 
                let arrayOfDictionaries = self.retrieveJSONFromRecords(records, for: type)
                
                if let data = try? JSONSerialization.data(withJSONObject: arrayOfDictionaries, options: []) {
                    do {
                        try FileManager.default.writeDataToDocuments(data: data, file: type.rawValue)
                        print("Succeeded \(type.rawValue)")
                    }
                    catch {
                        print("Could not save new data to documents.")
                    }
                }
            }
            DispatchQueue.main.async {
                self.objectWillChange.send() 
            }
        }
    }
    
    public func retrieveJSONFromRecords(_ records: [CKRecord], for type: PurchaseCalculatorDatabaseChildType) -> DictArray {
        switch type {
        case .attributes:
            return attributesJSONFromRecords(records)
        case .attributeMultiplierGroups:
            return attributeMultipliersGroupsFromRecords(records)
        case .strings:
            return stringsFromRecords(records)
        case .purchaseBrands:
            return brandsFromRecords(records)
        case .specificPurchaseUnits:
            return specificPurchaseUnitsFromRecords(records)
        case .specificPurchaseUnitGroups:
            return specificPurchaseUnitGroupsFromRecords(records)
        case .purchaseItems:
            return purchaseItemsFromRecords(records)
        case .purchaseItemGroups:
            return purchaseItemGroupsFromRecords(records)
        case .categories:
            return categoriesFromRecords(records)
        }
        
    }
    
    private func attributesJSONFromRecords(_ records: [CKRecord]) -> DictArray {
        var array: DictArray = []

        for record in records {
            let keys = record.allKeys()
            let ckRecordDictMap = keys.compactMap { ($0, record[$0] ?? "" )}
            var ckRecordDict = Dictionary(uniqueKeysWithValues: ckRecordDictMap)
            ckRecordDict["uuid"] = record.recordID.recordName
            array.append(ckRecordDict)
        }
        return array
    }
    
    private func attributeMultipliersGroupsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []

        var groups: Set<String> = []
        
        groups = Set(records.compactMap { ($0["group"] as? CKRecord.Reference)?.recordID.recordName })
        
        for group in groups {
            var dict = [String : Any]()
            let filteredRecords = records.filter { record in
                let groupReference = record["group"] as? CKRecord.Reference
                return groupReference?.recordID.recordName == group
            }
            let attributeAndMultipliers = filteredRecords.compactMap { record -> (String, Double)? in
                guard let attributeID = (record["attribute"] as? CKRecord.Reference)?.recordID.recordName,
                      let multiplier = record["multiplier"] as? Double else {
                    return nil
                }
                return (attributeID, multiplier)
            }
            
            let attributesAndMultipliersDictionary = Dictionary(uniqueKeysWithValues: attributeAndMultipliers)
                
            dict["attributeMultipliers"] = attributesAndMultipliersDictionary
            dict["uuid"] = group
            array.append(dict)
        }
        return array
    }
    
    private func brandsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        
        for record in records {
            let keys = record.allKeys()
            let pairs = keys.compactMap { ($0, record[$0] ?? "" )}
            var dict = Dictionary(uniqueKeysWithValues: pairs)
            dict["uuid"] = record.recordID.recordName
            array.append(dict)
        }
        return array
        
    }
    
    private func specificPurchaseUnitsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        
        for record in records {
            var dict: [String : Any] = [:]
            guard let brandReference = record["brand"] as? CKRecord.Reference else {
                continue
            }
            let brandID = brandReference.recordID.recordName
            dict["brandID"] = brandID
            dict["uuid"] = record.recordID.recordName
            dict["modelName"] = record["modelName"]
            dict["cost"] = record["cost"]
            array.append(dict)
        }
        return array
    }
    
    func specificPurchaseUnitGroupsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        
        for record in records {
            var dict: [String : Any] = [:]
            let reference = record["units"] as? [CKRecord.Reference]
            let ids = reference?.compactMap { $0.recordID.recordName }
            dict["unitIDs"] = ids
            dict["uuid"] = record.recordID.recordName
            array.append(dict)
        }
        return array
    }
    
    private func stringsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        var dict: [String:Any] = [:]

        for record in records {
            guard let key = record["key"] as? String,
                  let value = record["value"] as? String else {
                continue
            }
            dict[key] = value
        }
        array.append(dict)
        return array
        
    }
    
    private func purchaseItemsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        
        for record in records {
            var dict: [String:Any] = [:]
            guard let attributeMultiplierGroupReference = record["attributeMultiplierGroup"] as? CKRecord.Reference,
                  let specificPurchaseUnitGroupReference = record["specificPurchaseUnitGroup"] as? CKRecord.Reference else {
                continue
            }
            dict["attributeMultiplierGroupID"] = attributeMultiplierGroupReference.recordID.recordName
            dict["specificPurchaseUnitGroupID"] = specificPurchaseUnitGroupReference.recordID.recordName
            dict["handle"] = record["handle"]
            dict["imageName"] = record["imageName"]
            dict["uuid"] = record.recordID.recordName
            array.append(dict)
        }
        return array
    }
    
    private func purchaseItemGroupsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        
        for record in records {
            var dict: [String : Any] = [:]
            guard let purchaseItemsReferences = record["purchaseItems"] as? [CKRecord.Reference] else {
                continue
            }
            let ids = purchaseItemsReferences.compactMap { $0.recordID.recordName }
            dict["purchaseItemIDs"] = ids
            dict["uuid"] = record.recordID.recordName
            array.append(dict)
        }
        return array
    }
    
    private func categoriesFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        
        for record in records {
            var dict: [String : Any] = [:]
            guard let purchaseItemGroupReference = record["purchaseItemGroup"] as? CKRecord.Reference else {
                continue
            }
            dict["purchaseItemGroupID"] = purchaseItemGroupReference.recordID.recordName
            dict["handle"] = record["handle"]
            dict["imageName"] = record["imageName"]
            dict["uuid"] = record.recordID.recordName
            array.append(dict)
        }
        return array
    }
    
}
