//
//  GeneralPurposeCollectionViewCell.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/06/19.
//

import UIKit

class GeneralPurposeCollectionViewCell: UICollectionViewCell {
    private static var mockCell: GeneralPurposeCollectionViewCell = UINib(nibName: String(describing: GeneralPurposeCollectionViewCell.self), bundle: nil).instantiate(withOwner: GeneralPurposeCollectionViewCell.self, options: nil).first as! GeneralPurposeCollectionViewCell

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        configureView()
    }

    private func configureView() {
        titleLabel.text = nil
        titleLabel.isHidden = true
        icon.image = nil
        icon.isHidden = true
        descriptionLabel.text = nil
        descriptionLabel.isHidden = true
    }

    @discardableResult
    func configure(sampleModel: SampleModel) -> Self {
        if let title = sampleModel.title, title.count > 0 {
            titleLabel.text = title
            titleLabel.isHidden = false
        }

        if let iconUrlStr = sampleModel.iconUrlStr,
           let iconUrl = URL(string: iconUrlStr + "?id=\(sampleModel.id)")
        {
            icon.setImage(from: iconUrl)
            icon.isHidden = false
        }

        if let description = sampleModel.description,
           !description.isEmpty
        {
            descriptionLabel.text = description
            descriptionLabel.isHidden = false
        }

        // 値が決まってからlayoutをちゃんと更新する
        layoutIfNeeded()

        return self
    }

    static func calcSize(width: CGFloat, sampleModel: SampleModel, indexPath: IndexPath = IndexPath(row: 0, section: 0)) -> CGSize {
        // まず横幅を大きめのwidthを指定して制約に合わせてレイアウト更新する
        mockCell.bounds.size.width = width
        mockCell.contentView.bounds.size.width = width
        mockCell.configure(sampleModel: sampleModel)

        // パラメータに合わせてサイズを求める
        let size = mockCell.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )
        print("---------")
        print(indexPath)
        print(size)
        // 得られたサイズを返す
        return size
    }
}
