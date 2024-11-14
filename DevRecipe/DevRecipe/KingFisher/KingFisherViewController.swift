//
//  KingFisherViewController.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/11/14.
//

import UIKit
import Kingfisher

class KingFisherViewController: UIViewController {
    @IBOutlet weak var sampleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleImageView.kf.setImage(with: URL(string: "https://placehold.jp/300x200.png"), placeholder: UIImage(named: "sample"), options: [.transition(.fade(0.1)), .cacheOriginalImage]
        )
    }
}
