//
//  TouchTransparencyViewController.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/06/25.
//

import UIKit

class TransparentHeaderView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}

class TouchTransparencyViewController: UIViewController, UIScrollViewDelegate {
    private let headerView = TransparentHeaderView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let headerHeight: CGFloat = 100
    private let headerTitleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupHeaderView()
        setupStackView()
        addButtonsToStack()
        view.backgroundColor = .white
    }

    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        scrollView.backgroundColor = .white
    }

    private func setupHeaderView() {
        headerView.backgroundColor = UIColor.gray.withAlphaComponent(1)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        // タイトルラベルを追加
        headerTitleLabel.text = "Header Title"
        headerTitleLabel.textColor = .black
        headerTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerTitleLabel)
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: headerHeight),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: headerHeight),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func addButtonsToStack() {
        for i in 0..<20 {
            let button = UIButton(type: .system)
            button.setTitle("Button \(i+1)", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func buttonTapped(sender: UIButton) {
        print("\(sender.titleLabel?.text ?? "") tapped")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset < 0 {
            // スクロールがヘッダーを越えて上に行く場合、ヘッダーの位置を調整
            headerView.frame.origin.y = view.safeAreaInsets.top - offset
        } else {
            headerView.frame.origin.y = view.safeAreaInsets.top
        }

        // ヘッダーがスタックビューに被った時だけ透明度を調整
        let alpha = min(1, max(0, offset / headerHeight))
        headerView.backgroundColor = UIColor.gray.withAlphaComponent(1 - alpha * 0.5)
    }
}
