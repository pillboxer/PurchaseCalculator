//
//  CloudKitCoordinator.swift
//  PurchaseCalculatorDataKit
//
//  Created by Henry Cooper on 31/12/2020.
//

import Foundation
import CloudKit

public class CloudKitCoordinator: ObservableObject {
    
    @Published public var latestTypeFetched: PurchaseCalculatorDatabaseChildType?
    
    public static let shared = CloudKitCoordinator()
    
    public func updateJSON() {
        PurchaseCalculatorDatabaseChildType.allCases.forEach { updateJSON($0) }
    }
    
    private let db = CKContainer.default().publicCloudDatabase

    
    public func updateJSON(_ type: PurchaseCalculatorDatabaseChildType) {
        let query = CKQuery(recordType: type.singular, predicate: NSPredicate(value: true))
        db.perform(query, inZoneWith: nil) { (records, error) in
            if let records = records,
               !records.isEmpty {
                print("Records is not empty")
                var dict: [String: Any] = [:]
                
                for record in records {
                    let keys = record.allKeys()
                    let ckRecordDictMap = keys.compactMap { ($0, record[$0] ?? "" )}
                    var ckRecordDict = Dictionary(uniqueKeysWithValues: ckRecordDictMap)
                    ckRecordDict["uuid"] = UUID().uuidString
                    dict[UUID().uuidString] = ckRecordDict
                }
                if let data = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                    do {
                        try FileManager.default.writeDataToDocuments(data: data, file: type.rawValue)
                    }
                    catch {
                        BundledContentManager.shared.saveBundledContent(of: type)
                    }
                }
            }
            
            else {
                print("Saving of type \(type.rawValue)")
                BundledContentManager.shared.saveBundledContent(of: type)
            }
            
            self.latestTypeFetched = type
        }
    }
    
    public func createRecords(dict: [String: Any]) {
        let newRecord = CKRecord(recordType: "PurchaseAttributes")
        newRecord.setValue(UUID().uuidString, forKey: "uuid")
        
        for (key, value) in dict {
            newRecord.setValue(value, forKey: key)
        }
        
        db.save(newRecord) { (record, error) in
            print(record)
            print(error)
        }
    }
}
