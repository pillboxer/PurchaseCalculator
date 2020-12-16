//
//  LaunchHelper.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 16/12/2020.
//

import Foundation
import Combine
import SystemKit
import UIKit

class LaunchHelper {
    
    static let shared = LaunchHelper()
    
    private let reachability = SystemReachability.shared
    var cancellables = Set<AnyCancellable>()
        
    func start() {
        if UserDefaults.isFirstLaunch {
            BundledContentManager.shared.saveBundledContentToDisk()
            UserDefaults.isFirstLaunch = false
        }
        listenToConnectionStatus()
    }
    
    private func listenToConnectionStatus() {
        // Debounce stops spamming
        SystemReachability.shared.$connectionStatus
            .debounce(for: 3, scheduler: RunLoop.main)
            .sink { (connectionStatus) in
                self.updateJSONIfPossible()
            }.store(in: &cancellables)
    }
    
    private func updateJSONIfPossible() {
        if reachability.isConnected {
            FirebaseCoordinator.shared.updateJSON()
        }
    }
}
