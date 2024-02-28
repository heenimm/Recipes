// BenefitsInfoCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

private enum Constants {
    static let fontVerdana = "Verdana"
    static let fontVerdanaBold = "Verdana-Bold"
    static let pencil = "pencil"
    static let leftInset = UIScreen.main.bounds.width / 2 - 80
    static let greenColor = "AppGreen"
    static let lightGreenColor = "AppLightGreen"
}

/// Ячейка с преимуществами
final class BenefitsInfoCell: UITableViewCell {
    // MARK: - Static Constant

    static let reuseID = String(describing: BenefitsInfoCell.self)

    // MARK: - Visual Components

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: Constants.lightGreenColor)
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
        return imageView
    }()

    private let benefitTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(
            x: 51,
            y: 222,
            width: 256,
            height: 50
        ))
        label.font = UIFont(name: Constants.fontVerdana, size: 18)
        return label
    }()

    // MARK: - Life Cycle

    override func didMoveToSuperview() {
        setupSubviews()
        setupBenefitTitleLabelConstraints()
        setupIconImageViewConstraints()
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(benefitTitleLabel)
    }

    private func setupIconImageViewConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            iconImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            iconImageView.widthAnchor.constraint(equalToConstant: 48)

        ])
    }

    private func setupBenefitTitleLabelConstraints() {
        benefitTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            benefitTitleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 12
            ),
            benefitTitleLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: 16

            ),
            benefitTitleLabel.heightAnchor.constraint(equalToConstant: 24),
            benefitTitleLabel.widthAnchor.constraint(equalToConstant: 224)
        ])
    }
}

// MARK: - Extension

extension BenefitsInfoCell {
    func configure(_ infoBenefit: InfoBenefit) {
        iconImageView.image = UIImage(systemName: infoBenefit.menuImage)?.withTintColor(
            UIColor(named: Constants.greenColor)!,
            renderingMode: .alwaysOriginal
        )
        benefitTitleLabel.text = infoBenefit.menuTitle
    }
}
