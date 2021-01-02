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
    
    public func fetch(_ type: PurchaseCalculatorDatabaseChildType, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let query = CKQuery(recordType: type.cloudKitType, predicate: NSPredicate(value: true))
        db.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    public func link(_ id: String, to value: PurchaseCalculatorDatabaseValueType, belongingTo child: PurchaseCalculatorDatabaseChildType, withRecordID recordIDString: String) {
        
        let recordID = CKRecord.ID.init(recordName: recordIDString)
        
        db.fetch(withRecordID: recordID) { (record, error) in
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
                
                self.db.save(record) { (record, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        self.databaseAddingError = true
                    }
                    else {
                        self.latestChildLinkedTo = child
                    }
                }
            }
        }
    }
    
    public func addValues(_ parameters: [PurchaseCalculatorDatabaseValueType: Any], to child: PurchaseCalculatorDatabaseChildType) {
        
        let stringParams = parameters.map { (key: $0.key.rawValue, value: $0.value, reference: $0.key.childReference) }
        let record = CKRecord(recordType: child.cloudKitType)
        
        stringParams.forEach { param in
            if let referenceType = param.reference {
                let id = CKRecord.ID.init(recordName: param.value as? String ?? "")
                let referencedRecord = CKRecord(recordType: referenceType.cloudKitType, recordID: id)
                let reference = CKRecord.Reference(record: referencedRecord, action: .none)
                print(reference)
                record.setValue(reference, forKey: param.key)
            }
            else {
                record.setValue(param.value, forKey: param.key)
            }
        }
        
        db.save(record) { [self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
                self.databaseAddingError = true
            }
            else {
                latestChildAdded = child
            }
        }
    }
    
    public func updateJSON(_ type: PurchaseCalculatorDatabaseChildType) {
        fetch(type) { records, error in
            if let records = records,
               !records.isEmpty {
                let arrayOfDictionaries = self.retriever.retrieveJSONFromRecords(records, for: type)
                
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
                self.objectWillChange.send() 
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
