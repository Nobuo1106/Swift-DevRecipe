//
//  NetworkStatus.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/11/14.
//
import Foundation

enum NetworkStatus {
    case connectedViaWiFi
    case connectedViaCellular
    case connectedViaEthernet
    case disconnected
    
    var description: String {
        switch self {
        case .connectedViaWiFi:
            return "Wi-Fi接続"
        case .connectedViaCellular:
            return "セルラー接続"
        case .connectedViaEthernet:
            return "イーサネット接続"
        case .disconnected:
            return "インターネットに接続していません。"
        }
    }
}
