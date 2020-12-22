//
//  SystemKit.swift
//  SystemKit
//
//  Created by Henry Cooper on 31/10/2020.
//

import Foundation

public protocol SystemKitError: Error {
    var errorDescription: String { get }
    var code: Int { get }
}
