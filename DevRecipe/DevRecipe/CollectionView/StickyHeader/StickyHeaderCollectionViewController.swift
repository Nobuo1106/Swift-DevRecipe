//
//  StickyHeaderCollectionViewViewController.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/06/13.
//

import UIKit

class StickyHeaderCollectionViewController: UIViewController {
    private let items = SampleModel.demoData
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let cellNib = UINib(nibName: String(describing: GeneralPurposeCollectionViewCell.self), bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: String(describing: GeneralPurposeCollectionViewCell.self))
            collectionView.register(StickyCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: StickyCollectionHeaderView.self))
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    var stickyView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            view.heightAnchor.constraint(equalToConstant: 50),
            view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ]
        NSLayoutConstraint.activate(constraints)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension StickyHeaderCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        print("\(#function)")
        return .init(width: collectionView.frame.width, height: 200)
    }
}

extension StickyHeaderCollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GeneralPurposeCollectionViewCell.self), for: indexPath) as! GeneralPurposeCollectionViewCell
        let item = items[indexPath.item]
        cell.configure(sampleModel: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("\(#function)")
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: StickyCollectionHeaderView.self), for: indexPath) as! StickyCollectionHeaderView
        header.configure(stickyView: stickyView, viewController: self)
        return header
    }
}
