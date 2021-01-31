//
//  LaunchHelper.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 16/12/2020.
//

import Foundation
import Combine
import SystemKit
import PurchaseCalculatorDataKit
import UIKit

class LaunchHelper {
    
    static let shared = LaunchHelper()
    
    private let reachability = SystemReachability.shared
    var cancellables = Set<AnyCancellable>()
        
    func start() {
        #if EPHEMERAL
        UserDefaults.isFirstLaunch = true
        #endif
        
        if UserDefaults.isFirstLaunch {
            BundledContentManager.shared.saveBundledContentToDisk()
            UserDefaults.isFirstLaunch = false
        }
        listenToConnectionStatus()
    }
    
    private func listenToConnectionStatus() {
        SystemReachability.shared.$connectionStatus
            .sink { (_) in
                    CloudKitCoordinator.shared.fetchAllImages(since: Date(timeIntervalSince1970: UserDefaults.imageFetchTimeStamp)) { success in
                        UserDefaults.imageFetchTimeStamp = success ? Date().timeIntervalSince1970 : 0
                    }
                    CloudKitCoordinator.shared.updateJSON()
            }.store(in: &cancellables)
    }
}
