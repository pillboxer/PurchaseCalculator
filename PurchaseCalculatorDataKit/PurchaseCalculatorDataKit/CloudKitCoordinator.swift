//
//  CloudKitCoordinator.swift
//  PurchaseCalculatorDataKit
//
//  Created by Henry Cooper on 31/12/2020.
//

import Foundation
import CloudKit

public class CloudKitCoordinator: NSObject, ObservableObject {
    
    public static let shared = CloudKitCoordinator()
    private let retriever = CloudKitRetriever()
    
    @Published public var latestChildAdded: PurchaseCalculatorDatabaseChildType?
    @Published public var latestChildLinkedTo: PurchaseCalculatorDatabaseChildType?
    @Published public var databaseAddingError = false
    
    public func updateJSON() {
        PurchaseCalculatorDatabaseChildType.allCases.forEach { updateJSON($0) }
    }
    
    private let db = CKContainer(identifier: "iCloud.com.SixEye.purchaseCalculator").publicCloudDatabase
    
    public func link(_ id: String, to value: PurchaseCalculatorDatabaseValueType, belongingTo child: PurchaseCalculatorDatabaseChildType, withRecordID recordIDString: String) {
                
        fetchRecord(recordIDString) { [weak self] record in
            
            if let record = record {
                let referenceID = CKRecord.ID.init(recordName: id)
                let referenceRecord = CKRecord(recordType: value.rawValue, recordID: referenceID)
                let reference = CKRecord.Reference(record: referenceRecord, action: .none)
                
                let referenceToAdd: Any
                
                if var currentReferences = record[value.rawValue] as? [CKRecord.Reference] {
                    currentReferences.append(reference)
                    referenceToAdd = currentReferences
                }
                else {
                    referenceToAdd = value.isList ? [reference] : reference
                }

                record.setValue(referenceToAdd, forKey: value.rawValue)
                
                self?.db.save(record) { (record, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        self?.databaseAddingError = true
                    }
                    else {
                        self?.latestChildLinkedTo = child
                    }
                }
            }
        }
    }
}

// MARK: - Fetching
extension CloudKitCoordinator {
    
    public func fetch(_ type: PurchaseCalculatorDatabaseChildType, usingCloudKitType: Bool = false, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let query = CKQuery(recordType: usingCloudKitType ? type.cloudKitType : type.rawValue, predicate: NSPredicate(value: true))
        db.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    private func fetchRecord(_ uuid: String, completion: @escaping (CKRecord?) -> Void) {
        let recordID = CKRecord.ID(recordName: uuid)
        
        db.fetch(withRecordID: recordID) { [weak self] (record, error) in
            
            if let error = error {
                print(error.localizedDescription)
                self?.databaseAddingError = true
                return completion(nil)
            }
            
            if let record = record {
                return completion(record)
            }
        }
    }
}

// MARK: - Adding
extension CloudKitCoordinator {
    
    public func createNewMultiplierRecord(groupUUID: String, attributeUUID: String, multiplier: Double) -> CKRecord {
        let record = CKRecord(recordType: PurchaseCalculatorDatabaseChildType.attributeMultiplierGroups.cloudKitType)
        
        // Group
        let groupRecordID = CKRecord.ID(recordName: groupUUID)
        let groupRecord = CKRecord(recordType: PurchaseCalculatorDatabaseChildType.attributeMultiplierGroups.rawValue, recordID: groupRecordID)
        let newGroupReference = CKRecord.Reference(record: groupRecord, action: .deleteSelf)
        record.setValue(newGroupReference, forKey: "group")
        
        //Attribute
        let attributeRecordID = CKRecord.ID(recordName: attributeUUID)
        let attributeRecord = CKRecord(recordType: PurchaseCalculatorDatabaseChildType.attributes.rawValue, recordID: attributeRecordID)
        let newAttributeReference = CKRecord.Reference(record: attributeRecord, action: .deleteSelf)
        record.setValue(newAttributeReference, forKey: "attribute")
        
        // Multiplier
        record.setValue(multiplier, forKey: PurchaseCalculatorDatabaseValueType.multiplier.rawValue)
        
        return record
        
    }
    
    public func batchAdd(_ records: [CKRecord], child: PurchaseCalculatorDatabaseChildType) {
        let operation = CKModifyRecordsOperation(recordsToSave: records)
        db.add(operation)
        operation.completionBlock = {
            DispatchQueue.main.async {
                self.latestChildAdded = child
            }
        }
    }
    
    public func addValues(_ parameters: [PurchaseCalculatorDatabaseValueType: Any], to child: PurchaseCalculatorDatabaseChildType) {
        
        let stringParams = parameters.map { (key: $0.key.rawValue, value: $0.value, reference: $0.key.childReference) }
        let record = CKRecord(recordType: child.rawValue)
        
        stringParams.forEach { param in
            if let referenceType = param.reference {
                let id = CKRecord.ID.init(recordName: param.value as? String ?? "")
                let referencedRecord = CKRecord(recordType: referenceType.rawValue, recordID: id)
                let reference = CKRecord.Reference(record: referencedRecord, action: child.deleteSelfIfReferencesDeleted ? .deleteSelf : .none)
                print(reference)
                record.setValue(reference, forKey: param.key)
            }
            else {
                record.setValue(param.value, forKey: param.key)
            }
        }
        
        db.save(record) { [weak self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
                self?.databaseAddingError = true
            }
            else {
                self?.latestChildAdded = child
            }
        }
    }

}

// MARK: - Updating
extension CloudKitCoordinator {
        
    private func saveAndUpdateJSON(with record: CKRecord, for child: PurchaseCalculatorDatabaseChildType) {
        
        db.save(record) { [weak self] (_, error) in
            if let error = error {
                print(error)
                self?.databaseAddingError = true
                return
            }
            else {
                DispatchQueue.main.async {
                    self?.updateJSON()
                    self?.latestChildAdded = child
                }

            }
        }
    }
    
    public func updateEvaluationCountFor(uuid: String) {
        fetchRecord(uuid) { (record) in
            if let record = record {
                let evaluationCount = record.intFor(.evaluationCount)
                record.setValue(evaluationCount+1, forKey: PurchaseCalculatorDatabaseValueType.evaluationCount.rawValue)
                self.saveAndUpdateJSON(with: record, for: .specificPurchaseUnits)
            }
        }
    }
    
    public func updateValues(_ values: [PurchaseCalculatorDatabaseValueType:Any], withPredicate predicate: NSPredicate, for child: PurchaseCalculatorDatabaseChildType) {
        let query = CKQuery(recordType: child.rawValue, predicate: predicate)
      
        db.perform(query, inZoneWith: nil) { [weak self] (records, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            let recordsCount = records?.count ?? 0
            
            if recordsCount == 0 {
                self?.databaseAddingError = true
                return
            }
            
            if let record = records?.first {
                values.forEach { record.setValue($0.value, forKey: $0.key.rawValue) }
                self?.saveAndUpdateJSON(with: record, for: child)
            }
        }
    }

    
    public func updateValues(_ values: [PurchaseCalculatorDatabaseValueType:Any], for child: PurchaseCalculatorDatabaseChildType, belongingTo uuid: String) {
        fetchRecord(uuid) { [weak self] (record) in
            if let record = record {
                values.forEach { record.setValue($0.value, forKey: $0.key.rawValue) }
                self?.saveAndUpdateJSON(with: record, for: child)
            }
        }
    }
    
    public func updateJSON(_ type: PurchaseCalculatorDatabaseChildType) {
        let useCloudKitType = type == .attributeMultiplierGroups
        fetch(type, usingCloudKitType: useCloudKitType) { [weak self] records, error in
            if let records = records,
               !records.isEmpty {
                let arrayOfDictionaries = self?.retriever.retrieveJSONFromRecords(records, for: type) ?? []
                
                if let data = try? JSONSerialization.data(withJSONObject: arrayOfDictionaries, options: []) {
                    do {
                        try FileManager.default.writeDataToDocuments(data: data, file: type.rawValue)
                    }
                    catch {
                        print("Could not save new data to documents.")
                    }
                }
            }
            DispatchQueue.main.async {
                self?.objectWillChange.send()
            }
        }
    }
}

public extension CKRecord {
    
    var uuid: String {
        recordID.recordName
    }
    
    func referenceName(for parameter: String) -> String? {
        (self[parameter] as? CKRecord.Reference)?.recordID.recordName
    }
    
    func doubleFor(_ value: PurchaseCalculatorDatabaseValueType) -> Double {
        retrieve(type: Double.self, fromPath: value.rawValue, defaultType: .zero)
    }
    
    func intFor(_ value: PurchaseCalculatorDatabaseValueType) -> Int {
        retrieve(type: Int.self, fromPath: value.rawValue, defaultType: .zero)
    }
    
    func stringFor(_ value: PurchaseCalculatorDatabaseValueType) -> String {
        retrieve(type: String.self, fromPath: value.rawValue, defaultType: "")
    }
    
    func stringsFor(_ value: PurchaseCalculatorDatabaseValueType) -> [String] {
        retrieve(type: [String].self, fromPath: value.rawValue, defaultType: [])
    }
    
    func referencesFor(_ value: PurchaseCalculatorDatabaseValueType) -> [CKRecord.Reference] {
        retrieve(type: [CKRecord.Reference].self, fromPath: value.rawValue, defaultType: [])
    }
    
    private func retrieve<T>(type: T.Type, fromPath path: String, defaultType: T) -> T {
        self[path] as? T ?? defaultType
    }
    
}
