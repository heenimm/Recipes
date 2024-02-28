// BonusesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Информация о бонусах
final class BonusesViewController: UIViewController {
    
    private enum Constants {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let bonusesImage = "bonusesImage"
        static let xmarkImage = "xmark"
        static let yourBonusesText = "Your bonuses"
        static let countBonusText = "⭐️ 100"
        static let leftInset = UIScreen.main.bounds.width / 2 - 80
        static let termsTitleText = "Terms of Use"
        static let termsKeyText = "terms_use"
    }

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
        button.addTarget(self, action: #selector(dismissBottom), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Constants.yourBonusesText
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 20)
        return label
    }()

    private let countBonusLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.countBonusText
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 30)
        return label
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        setupSubviews()
        setupTitleLabelConstraints()
        setupCloseButtonConstraints()
        setupBonusImageViewConstraints()
        setupCountBonusLabelConstraints()
    }

    // MARK: - Public Methods

    @objc func dismissBottom() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(bonusImageView)
        view.addSubview(countBonusLabel)
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
            titleLabel.widthAnchor.constraint(equalToConstant: 360)

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

    private func setupBonusImageViewConstraints() {
        bonusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bonusImageView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 13
            ),
            bonusImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 130
            ),
            bonusImageView.heightAnchor.constraint(equalToConstant: 136),
            bonusImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func setupCountBonusLabelConstraints() {
        countBonusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countBonusLabel.topAnchor.constraint(equalTo: bonusImageView.bottomAnchor, constant: 12),
            countBonusLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 120
            ),
            countBonusLabel.heightAnchor.constraint(equalToConstant: 24),
            countBonusLabel.widthAnchor.constraint(equalToConstant: 216)

        ])
    }
}
