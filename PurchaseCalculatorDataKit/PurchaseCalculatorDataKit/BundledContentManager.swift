//
//  BundledContentManager.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 14/12/2020.
//

import Foundation
import SystemKit

public class BundledContentManager: NSObject {
    
    // MARK: - Private
    private let fileManager = FileManager.default
    
    // MARK: - Static
    public static let shared = BundledContentManager()
    
    public func saveBundledContentToDisk() {
        print("SAVING EVERYTHING")
        PurchaseCalculatorDatabaseChildType.allCases.forEach { saveBundledContent(of: $0) }
    }
    
    public func saveBundledContent(of type: PurchaseCalculatorDatabaseChildType) {
        do {
            let bundle = Bundle(for: classForCoder)
            let data = try fileManager.dataFromBundle(bundle: bundle, file: type.rawValue, type: "json")
            try fileManager.writeDataToLibrary(data: data, file: type.rawValue, folder: "Emptor/JSON")
        }
        catch let error {
            print("Could not save bundled contents - \(error)")
        }
    }
    
}
