//
//  UIKitWithoutViewModelView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/10.
//

import UIKit

protocol UIKitWithoutViewModelViewDelegate: AnyObject {
    func uiKitWithoutViewModelViewDidTapButton()
}

final class UIKitWithoutViewModelView: UIView {
    weak var delegate: UIKitWithoutViewModelViewDelegate?
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [verticalStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, button, tapCountLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Tap Me",
                        for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self,
                         action: #selector(didTapButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var tapCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Button Tap Counter: \(tapCount)"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private var tapCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

extension UIKitWithoutViewModelView {
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}

private extension UIKitWithoutViewModelView {
    func setupUI() {
        addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc
    func didTapButton() {
        tapCount += 1
        tapCountLabel.text = "Button Tap Counter: \(tapCount)"
        delegate?.uiKitWithoutViewModelViewDidTapButton()
    }
}
