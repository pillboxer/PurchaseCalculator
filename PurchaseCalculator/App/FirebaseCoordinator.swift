//
//  FirebaseManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 12/12/2020.
//

import Foundation
import FirebaseKit
import SystemKit
import Combine

class FirebaseCoordinator: ObservableObject {
    
    static let shared = FirebaseCoordinator()
        
    var cancellables = Set<AnyCancellable>()
    
    func updateJSON() {
        PurchaseCalculatorJSONFileType.allCases.forEach { updateJSON($0) }
    }
            
    private func updateJSON(_ type: PurchaseCalculatorJSONFileType) {
        FirebaseManager.shared.listenTo(type.rawValue) { (data) in
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
}
