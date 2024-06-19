//
//  StickyHeaderView.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/06/17.
//

import UIKit

final class StickyCollectionHeaderView: UICollectionReusableView {
    let stickyContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stickyContainerView)
        stickyContainerView.translatesAutoresizingMaskIntoConstraints = false
        let dummyHeightConst = stickyContainerView.heightAnchor.constraint(equalToConstant: 0)
        dummyHeightConst.priority = .init(rawValue: 1)
        let constraints = [
            stickyContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: stickyContainerView.trailingAnchor),
            bottomAnchor.constraint(equalTo: stickyContainerView.bottomAnchor),
            dummyHeightConst
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(stickyView: UIView, viewController: UIViewController) {
        if !stickyContainerView.subviews.contains(where: { $0 == stickyView }) {
            print("\(#function) add")
            viewController.view.addSubview(stickyView)
            stickyView.translatesAutoresizingMaskIntoConstraints = false

            let yConst = stickyView.centerYAnchor.constraint(equalTo: stickyContainerView.centerYAnchor)
            yConst.priority = .init(rawValue: 1)
            let constraints: [NSLayoutConstraint] = [
                stickyView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                stickyView.topAnchor.constraint(greaterThanOrEqualTo: viewController.view.safeAreaLayoutGuide.topAnchor),
                stickyContainerView.heightAnchor.constraint(equalTo: stickyView.heightAnchor),
                yConst,
            ]

            NSLayoutConstraint.activate(constraints)
        }
        print("\(#function)")
        backgroundColor = .red
    }
}
