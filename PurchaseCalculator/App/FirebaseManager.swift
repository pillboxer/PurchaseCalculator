//
//  FirebaseManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 12/12/2020.
//

import Foundation
import FirebaseDatabase
import SystemKit
import Combine

class FirebaseManager: ObservableObject {
    
    static let shared = FirebaseManager()
    
    lazy var databaseReference: DatabaseReference = {
        Database.database(url: "https://purchasecalculator-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }()
    
    @Published var isLoadingJSON = false
    
    func updateLocalJSON() {
        isLoadingJSON = true
        var count = 0
        for json in PurchaseCalculatorJSONFileType.allCases {
            databaseReference.child(json.rawValue).observeSingleEvent(of: .value) { (snapshot) in
                if let value = snapshot.value,
                   let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) {
                    try? FileManager.default.writeDataToDocuments(data: jsonData, file: json.rawValue)
                    count += 1
                    if count == PurchaseCalculatorJSONFileType.allCases.count {
                        self.isLoadingJSON = false
                    }
                }
            }
        }
    }
}
