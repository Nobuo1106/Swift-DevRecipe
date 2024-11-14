//
//  NetworkMonitor.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/11/14.
//

import Network

class NetworkMonitor {
    typealias NetworkStatusHandler = (NetworkStatus) -> Void
    private let monitor = NWPathMonitor()
    
    func startMonitoring(statusChangeHandler: @escaping NetworkStatusHandler) {
        monitor.pathUpdateHandler = { path in
            var newStatus: NetworkStatus
            
            switch path.status {
            case .satisfied:
                switch true {
                case path.usesInterfaceType(.wifi):
                    newStatus = .connectedViaWiFi
                case path.usesInterfaceType(.cellular):
                    newStatus = .connectedViaCellular
                case path.usesInterfaceType(.wiredEthernet):
                    newStatus = .connectedViaEthernet
                default:
                    newStatus = .disconnected
                }
            case .unsatisfied, .requiresConnection:
                newStatus = .disconnected
            @unknown default:
                newStatus = .disconnected
            }
            statusChangeHandler(newStatus)
        }
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }
}
