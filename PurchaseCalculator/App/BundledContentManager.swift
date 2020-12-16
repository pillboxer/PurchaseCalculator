//
//  BundledContentManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 14/12/2020.
//

import Foundation
import SystemKit

class BundledContentManager {
    
    // MARK: - Private
    private let fileManager = FileManager.default
    
    // MARK: - Static
    static let shared = BundledContentManager()
    
    func saveBundledContentToDisk() {
        
        PurchaseCalculatorJSONFileType.allCases.forEach { (type) in
            do {
                let data = try fileManager.dataFromBundle(file: type.rawValue, type: "json")
                try fileManager.writeDataToDocuments(data: data, file: type.rawValue)
            }
            catch let error {
                print("Could not save bundled contents - \(error)")
            }
        }
        
    }
    
}
