//
//  NWPathMonitorViewController.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/11/14.
//

import UIKit
import Network

class NWPathMonitorViewController: UIViewController {
    private let networkMonitor = NetworkMonitor()

    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        startNetworkMonitoring()
    }
    
    private func startNetworkMonitoring() {
        networkMonitor.startMonitoring { [weak self] status in
            guard let self else { return }
            DispatchQueue.main.async {
                self.statusLabel.text = status.description
            }
        }
    }
}
