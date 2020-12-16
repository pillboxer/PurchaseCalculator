//
//  FirebaseManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 12/12/2020.
//

import Foundation
import Firebase
import FirebaseDatabase
import Combine

class FirebaseManager: ObservableObject {
    
    static let shared = FirebaseManager()
    
    lazy var databaseReference: DatabaseReference = {
        Database.database(url: "https://purchasecalculator-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }()
    
    init() {
        FirebaseApp.configure()
    }
    
    var cancellables = Set<AnyCancellable>()
        
    func updateJSON() {
        PurchaseCalculatorJSONFileType.allCases.forEach { self.updateJSON($0)}
    }
    
    private func updateJSON(_ type: PurchaseCalculatorJSONFileType) {
        databaseReference.child(type.rawValue).observe(.value) { (snapshot) in
            if let value = snapshot.value,
               let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) {
                do {
                    try FileManager.default.writeDataToDocuments(data: jsonData, file: type.rawValue)
                }
                catch let error {
                    // If something goes wrong, save the bundled content
                    BundledContentManager.shared.saveBundledContentToDisk()
                    print(error)
                }
            }
            self.objectWillChange.send()
        }
    }
}
