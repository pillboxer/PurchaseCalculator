//
//  FirebaseManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 12/12/2020.
//

import Foundation
import FirebaseKit
import Firebase
import Combine

public class FirebaseCoordinator: ObservableObject {
    
    public static let shared = FirebaseCoordinator()
    private let manager = FirebaseManager.shared
    
    @Published public var latestChildAdded: PurchaseCalculatorDatabaseChildType?
    @Published public var databaseAddingError = false
    
    public func updateJSON() {
        PurchaseCalculatorDatabaseChildType.allCases.forEach { updateJSON($0) }
    }
            
    private func updateJSON(_ type: PurchaseCalculatorDatabaseChildType) {
        manager.listenTo(type.rawValue) { (data) in
            if let data = data {
                do {
                    try FileManager.default.writeDataToDocuments(data: data, file: type.rawValue)
                }
                catch {
                    BundledContentManager.shared.saveBundledContentToDisk()
                }
            }
            self.objectWillChange.send()
        }
    }
    
    public func retrieveDatabaseChildren(_ type: PurchaseCalculatorDatabaseChildType?, completion: @escaping (DataSnapshot) -> Void) {
        manager.getChild(type?.rawValue) { (snapshot) in
            completion(snapshot)
        }
    }
    
    public func addValues(_ parameters: [PurchaseCalculatorDatabaseValueType: Any], to child: PurchaseCalculatorDatabaseChildType) {
        let stringParams = parameters.map { ($0.key.rawValue, $0.value) }
        let newParams = Dictionary(uniqueKeysWithValues: stringParams)
        manager.addToChild(child.rawValue, values: newParams) { success in
            self.latestChildAdded = success ? child : nil
            self.databaseAddingError = !success
        }
    }
    
    public func addToArray(_ string: String, to valueType: PurchaseCalculatorDatabaseValueType, belongingTo childType: PurchaseCalculatorDatabaseChildType, with key: String) {
        let child = valueType.rawValue
        let parent = childType.rawValue
        manager.addValue(string, to: child, of: parent, with: key) { success in
            self.latestChildAdded = success ? childType : nil
            self.databaseAddingError = !success
        }
    }
    
    public func updateValue(of valueType: PurchaseCalculatorDatabaseValueType, belongingTo childType: PurchaseCalculatorDatabaseChildType, withKey key: String, to newValue: String) {
        let child = valueType.rawValue
        let parent = childType.rawValue
        manager.updateValue(of: child, with: parent, parentKey: key, to: newValue) { success in
            self.latestChildAdded = success ? childType : nil
            self.databaseAddingError = !success
        }
    }
}

public extension DataSnapshot {

    var childSnapshots: [DataSnapshot] {
        children.allObjects.compactMap { $0 as? DataSnapshot }
    }
    
    private func doubleFrom(_ type: PurchaseCalculatorDatabaseValueType) -> Double {
        retrieve(type: Double.self, fromPath: type.rawValue, defaultType: Double.zero)
    }
    
    private func stringFrom(_ type: PurchaseCalculatorDatabaseValueType) -> String {
        retrieve(type: String.self, fromPath: type.rawValue, defaultType: "")
    }
    
    private func stringsFrom(_ type: PurchaseCalculatorDatabaseValueType) -> [String] {
        let dict = retrieve(type: [String:String].self, fromPath: type.rawValue, defaultType: [:])
        return Array(dict.values)
    }
    
    private func retrieve<T>(type: T.Type, fromPath path: String, defaultType: T) -> T {
        return childSnapshot(forPath: path).value as? T ?? defaultType
    }
    
}
