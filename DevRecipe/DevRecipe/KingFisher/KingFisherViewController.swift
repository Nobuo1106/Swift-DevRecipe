//
//  KingFisherViewController.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/11/14.
//

import UIKit
import Kingfisher

class KingFisherViewController: UIViewController {
    @IBOutlet weak var setImageImageView: UIImageView!
    @IBOutlet weak var KingFisherManagerImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKingFisher()
    }
    
    private func setupKingFisher() {
        //kf.setImageを利用した場合
        setImageImageView.kf.setImage(with: URL(string: "https://placehold.jp/300x200.png"), placeholder: UIImage(named: "sample"), options: [.transition(.fade(0.1)), .cacheOriginalImage]
        )
        
        // KingfisherManagerを利用した場合
        KingfisherManager.shared.retrieveImage(with: URL(string: "https://picsum.photos/200/300")!) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.KingFisherManagerImageView.image = value.image
                }
            case .failure:
                DispatchQueue.main.async {
                    self.KingFisherManagerImageView.image = UIImage(named: "sample")
                }
            }
        }
    }
}
