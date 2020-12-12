//
//  GlobalProtocols.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 21/11/2020.
//

import Combine
import Foundation
import SystemKit

protocol ErrorPublisher: ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    var currentErrorMessage: String? { get set }
}

extension ErrorPublisher {

    func publishErrorMessage(_ error: Error) {
        currentErrorMessage = (error as? SystemKitError)?.errorDescription ?? error.localizedDescription
        objectWillChange.send()
    }

}

protocol RowType: Identifiable {
    var uuid: String { get }
    var title: String { get }
    var imageName: String { get }
    var isSystemImage: Bool { get }
}

extension RowType {
    
    var id: String {
        uuid
    }
    
    var isSystemImage: Bool {
        false
    }
}
