//
//  ViewController.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum ViewType: String, CaseIterable {
        case StickyHeaderCollection
        case TouchTransparency
        var viewController: UIViewController {
            switch self {
            case .StickyHeaderCollection:
                UIStoryboard.stickyHeaderCollection.instantiateInitialViewController() as! StickyHeaderCollectionViewController
            case .TouchTransparency:
                TouchTransparencyViewController()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toStickyHeaderDidTap(_ sender: UIButton) {
        navigationController?.pushViewController(ViewType.StickyHeaderCollection.viewController, animated: true)
    }
    
    @IBAction func toTouchTransParencydidTap(_ sender: UIButton) {
        navigationController?.pushViewController(ViewType.TouchTransparency.viewController, animated: true)
    }
}

