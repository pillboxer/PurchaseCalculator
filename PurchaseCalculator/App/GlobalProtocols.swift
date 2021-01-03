//
//  GlobalProtocols.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import Combine
import SystemKit
import PurchaseCalculatorDataKit
import SwiftUI

// MARK: - Errors
protocol ErrorPublisher: ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    var currentErrorMessage: String? { get set }
}

extension ErrorPublisher {

    func publishErrorMessage(_ error: Error) {
        currentErrorMessage = (error as? SystemKitError)?.errorDescription ?? error.localizedDescription
        objectWillChange.send()
    }

}

// MARK: - UI
protocol RowType: Identifiable {
    var uuid: String { get }
    var imageName: String { get }
    var isSystemImage: Bool { get }
    var rowTitle: String { get }
}

extension RowType {
    
    var id: String {
        uuid
    }
    
    var isSystemImage: Bool {
        false
    }
}

