// BonusesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

private enum Constants {
    static let fontVerdana = "Verdana"
    static let fontVerdanaBold = "Verdana-Bold"
    static let bonusesImage = "bonusesImage"
    static let xmarkImage = "xmark"
    static let yourBonusesText = "Your bonuses"

    static let leftInset = UIScreen.main.bounds.width / 2 - 80
    static let termsTitleText = "Terms of Use"
    static let termsKeyText = "terms_use"
}

/// Информация о бонусах
final class BonusesViewController: UIViewController {
    // MARK: - Static Constant

    static let reuseID = String(describing: PersonalInfoCell.self)

    // MARK: - Visual Components

    private let bonusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.bonusesImage)
        return imageView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.setImage(UIImage(systemName: Constants.xmarkImage), for: .normal)
        button.addTarget(BonusesViewController.self, action: #selector(dismissBottom), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.yourBonusesText
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 20)
        return label
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        setupSubviews()
        setupTitleLabelConstraints()
        setupCloseButtonConstraints()
        setupTermsUseTextLabelConstraints()
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(bonusImageView)
    }

    @objc func dismissBottom() {
        dismiss(animated: true)
    }

    private func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.widthAnchor.constraint(equalToConstant: 350)

        ])
    }

    private func setupCloseButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 20
            ),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -15

            ),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func setupTermsUseTextLabelConstraints() {
        bonusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bonusImageView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 83
            ),
            bonusImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 120
            ),
            bonusImageView.heightAnchor.constraint(equalToConstant: 136),
            titleLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
