//
//  SystemReachability.swift
//  SystemKit
//
//  Created by Henry Cooper on 16/12/2020.
//

import Foundation
import Network

public class SystemReachability: ObservableObject {
    
    // MARK: - Static
    public static let shared = SystemReachability()

    // MARK: - Private
    private let nwMonitor = NWPathMonitor()
    @Published public var connectionStatus: ConnectionStatus = .disconnected
    
    // MARK: - Initialisation
    init() {
        startMonitoring()
    }
    
    public enum ConnectionStatus {
        case wifi
        case mobile
        case disconnected
        
        public var isConnected: Bool {
            self != .disconnected
        }
        
        init(_ path: NWPath) {
            switch path.status {
            case .unsatisfied, .requiresConnection:
                self = .disconnected
            case .satisfied:
                self = path.isExpensive ? .mobile : .wifi
            @unknown default:
                self = .disconnected
            }
        }
    }
    
    private func startMonitoring() {
        nwMonitor.pathUpdateHandler = { path in
            self.connectionStatus = path.status == .unsatisfied ? .disconnected : .mobile
        }
        nwMonitor.start(queue: .main)
    }
    
}
