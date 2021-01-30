//
//  FileManager+Extensions.swift
//  SystemKit
//
//  Created by Henry Cooper on 31/10/2020.
//

import Foundation
import UIKit

extension FileManager {
    
    var library: URL! {
        urls(for: .libraryDirectory, in: .userDomainMask).first
    }
    
    enum FileManagerError: SystemKitError {
        case couldNotOpenFile
        case couldNotCreateData
        case couldNotCreateFolder
        case couldNotOpenDocuments
        case couldNotWriteToDocuments
        
        var errorDescription: String {
            switch self {
            case .couldNotOpenFile:
                return "Could Not Open File"
            case .couldNotCreateData:
                return "Could Not Create Data"
            case .couldNotCreateFolder:
                return "Could Not Create Folder"
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
            case .couldNotCreateFolder:
                return 005
            }
        }
    }
    
    public func createFolderIfNecessary(name: String)  {
        let url = library.appendingPathComponent(name)
        if !fileExists(atPath: url.path) {
            do {
                try createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print(FileManagerError.couldNotCreateFolder.errorDescription)
            }
        }
    }
    
    public func savePNGToFolder(name: String) {
        
    }
    
    public func dataFromBundle(bundle: Bundle, file: String, type: String) throws -> Data {
        guard let path = bundle.path(forResource: file, ofType: type),
              let file = try? String(contentsOfFile: path),
              let data = file.data(using: .utf8) else {
            throw FileManagerError.couldNotOpenFile
        }
        return data
    }
    
    public func imageFromLibrary(file: String, folder: String? = nil) -> UIImage? {
        let folder = folder ?? ""
        let url = library.appendingPathComponent(folder).appendingPathComponent(file)
        return UIImage(contentsOfFile: url.path)
    }
    
    public func dataFromLibrary(file: String, folder: String? = nil) throws -> Data {
        do {
            let folder = folder ?? ""
            let url = library.appendingPathComponent(folder).appendingPathComponent(file)
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
    
    public func writeDataToLibrary(data: Data, file: String, folder: String?) throws  {
        let url: URL
        if let folder = folder {
            createFolderIfNecessary(name: folder)
            url = library.appendingPathComponent(folder).appendingPathComponent(file)
        }
        else {
            url = library.appendingPathComponent(file)
        }
        do {
            try data.write(to: url)
        }
        catch let error {
            print(error)
            throw FileManagerError.couldNotWriteToDocuments
        }
    }
    
}
