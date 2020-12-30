//
//  FileManager+Extensions.swift
//  SystemKit
//
//  Created by Henry Cooper on 31/10/2020.
//

import Foundation

extension FileManager {
    
    var documentsURL: URL! {
        urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    enum FileManagerError: SystemKitError {
        case couldNotOpenFile
        case couldNotCreateData
        case couldNotOpenDocuments
        case couldNotWriteToDocuments
        
        var errorDescription: String {
            switch self {
            case .couldNotOpenFile:
                return "Could Not Open File"
            case .couldNotCreateData:
                return "Could Not Create Data"
            case .couldNotOpenDocuments:
                return "Could Not Open Documents"
            case .couldNotWriteToDocuments:
                return "Could Not Write To Documents"
            }
        }
        
        var code: Int {
            switch self {
            case .couldNotOpenFile:
                return 000
            case .couldNotCreateData:
                return 001
            case .couldNotOpenDocuments:
                return 003
            case .couldNotWriteToDocuments:
                return 004
            }
        }
    }
    
    public func dataFromBundle(bundle: Bundle, file: String, type: String) throws -> Data {
        guard let path = bundle.path(forResource: file, ofType: type),
              let file = try? String(contentsOfFile: path),
              let data = file.data(using: .utf8) else {
            throw FileManagerError.couldNotOpenFile
        }
        return data
    }
    
    func dataFromDocuments(file: String) throws -> Data {
        do {
            let url = documentsURL.appendingPathComponent(file)
            let file = try String(contentsOf: url)
            if let data = file.data(using: .utf8) {
                return data
            }
            else {
                throw FileManagerError.couldNotCreateData
            }
        }
        catch let error {
            print(error)
            throw FileManagerError.couldNotCreateData
        }
    }
    
    public func writeDataToDocuments(data: Data, file: String) throws  {
        do {
            print("Writing: \(file)")
            try data.write(to: documentsURL.appendingPathComponent(file))
        }
        catch let error {
            print(error)
            throw FileManagerError.couldNotWriteToDocuments
        }
    }
    
}
