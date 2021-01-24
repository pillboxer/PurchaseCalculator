//
//  CloudKitRetriever.swift
//  PurchaseCalculatorDataKit
//
//  Created by Henry Cooper on 02/01/2021.
//

import CloudKit

class CloudKitRetriever {
    
    public typealias DictArray = [[String : Any]]
    
    func retrieveJSONFromRecords(_ records: [CKRecord], for type: PurchaseCalculatorDatabaseChildType) -> DictArray {
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
        case .homescreenBlockContainers, .evaluationScreenBlockContainers:
            return blockContainersFromRecords(records)
        case .homescreenBlocks, .evaluationScreenBlocks:
            return blocksFromRecords(records)
        default:
            return DictArray()
        }
    }
    
    private func getBasicKeysAndValuesFrom(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        
        for record in records {
            let keys = record.allKeys()
            let pairs = keys.compactMap { ($0, record[$0] ?? "" )}
            var dict = Dictionary(uniqueKeysWithValues: pairs)
            dict["uuid"] = record.uuid
            array.append(dict)
        }
        return array
    }
        
    private func attributesJSONFromRecords(_ records: [CKRecord]) -> DictArray {
        getBasicKeysAndValuesFrom(records)
    }
    
    private func brandsFromRecords(_ records: [CKRecord]) -> DictArray {
        getBasicKeysAndValuesFrom(records)
    }
    
    private func blocksFromRecords(_ records: [CKRecord]) -> DictArray {
        getBasicKeysAndValuesFrom(records)
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
    
    private func specificPurchaseUnitsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        
        for record in records {
            var dict: [String : Any] = [:]
            let brandID = record.referenceName(for: "brand")
            dict["brandID"] = brandID
            dict["uuid"] = record.recordID.recordName
            dict["modelName"] = record.stringFor(.modelName)
            dict["cost"] = record.doubleFor(.cost)
            dict["evaluationCount"] = record.intFor(.evaluationCount)
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
            dict["uuid"] = record.uuid
            array.append(dict)
        }
        return array
    }
    
    private func stringsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        var dict: [String:Any] = [:]
        
        for record in records {
            let key = record.stringFor(.key)
            let value = record.stringFor(.value)
            dict[key] = value
        }
        array.append(dict)
        return array
        
    }
    
    private func purchaseItemsFromRecords(_ records: [CKRecord]) -> DictArray {
        
        var array: DictArray = []
        
        for record in records {
            var dict: [String:Any] = [:]
            dict["attributeMultiplierGroupID"] = record.referenceName(for: "attributeMultiplierGroup")
            dict["specificPurchaseUnitGroupID"] = record.referenceName(for: "specificPurchaseUnitGroup")
            dict["handle"] = record.stringFor(.handle)
            dict["imageName"] = record.stringFor(.imageName)
            dict["uuid"] = record.uuid
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
            dict["purchaseItemGroupID"] = record.referenceName(for: "purchaseItemGroup")
            dict["handle"] = record.stringFor(.handle)
            dict["imageName"] = record.stringFor(.imageName)
            dict["uuid"] = record.uuid
            array.append(dict)
        }
        return array
    }
    
    private func blockContainersFromRecords(_ records: [CKRecord]) -> DictArray {
        var array: DictArray = []
        
        for record in records {
            var dict: [String : Any] = [:]
            guard let blocksReferences = record["blocks"] as? [CKRecord.Reference] else {
                continue
            }
            let ids = blocksReferences.compactMap { $0.recordID.recordName }
            dict["blockIDs"] = ids
            dict["uuid"] = record.uuid
            dict["isHidden"] = record.stringFor(.isHidden)
            dict["position"] = record.intFor(.position)
            array.append(dict)
        }
        
        return array
        
    }
    
}
