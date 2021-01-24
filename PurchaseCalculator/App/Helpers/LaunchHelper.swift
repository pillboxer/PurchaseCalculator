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
        
        // FIXME: - 
        let date = Date(timeIntervalSince1970: UserDefaults.imageFetchTimeStamp)
        CloudKitCoordinator.shared.fetchAllImages(since: date)
        UserDefaults.imageFetchTimeStamp = Date().timeIntervalSince1970

        
        
        if UserDefaults.isFirstLaunch {
            BundledContentManager.shared.saveBundledContentToDisk()
            UserDefaults.isFirstLaunch = false
        }
        listenToConnectionStatus()
    }
    
    private func listenToConnectionStatus() {
        SystemReachability.shared.$connectionStatus
            .sink { (connectionStatus) in
                if connectionStatus != .disconnected {
                    CloudKitCoordinator.shared.updateJSON()
                }
            }.store(in: &cancellables)
    }
}
