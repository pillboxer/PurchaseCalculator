//
//  JSONDecoder+Extensions.swift
//  SystemKit
//
//  Created by Henry Cooper on 31/10/2020.
// 

import Foundation

public extension JSONDecoder {
    
    enum JSONDecoderError: SystemKitError {
        case couldNotDecode(String)
        
        public var errorDescription: String {
            switch self {
            case .couldNotDecode(let error):
                return "Could not decode JSON: \(error)"
            }
        }
        
        public var code: Int {
            switch self {
            case .couldNotDecode:
                return 002
            }
        }
    }
    
    static func decodeLocalJSON<T: Decodable>(file: String, type: T.Type) throws -> T {
        let fileManager = FileManager.default
        let decoder = JSONDecoder()
        do {
            let data = try fileManager.dataFromDocuments(file: file)
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        }
        catch let error {
            print(error)
            let errorString = String(describing: error)
            throw JSONDecoderError.couldNotDecode(errorString)
        }
    }

}
