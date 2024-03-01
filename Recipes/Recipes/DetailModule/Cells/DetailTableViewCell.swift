// DetailTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Виды блюд
final class DetailTableViewCell: UITableViewCell {
    // MARK: - Enums

    private enum Constants {
        static let fontVerdana = "Verdana"
        static let leftInset = UIScreen.main.bounds.width / 2 - 80
    }

    // MARK: - Static Constant

    static let reuseID = String(describing: DetailTableViewCell.self)

    // MARK: - Visual Components

    private let dishPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let dishDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Life Cycle

    override func didMoveToSuperview() {
        setupSubviews()
        setupDishPhotoImageViewConstraints()
        setupDishDescriptionLabelConstraints()
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        contentView.backgroundColor = UIColor(named: "appBottomGradient")

        contentView.layer.cornerRadius = contentView.bounds.width / 20
        contentView.addSubview(dishPhotoImageView)
        contentView.addSubview(dishDescriptionLabel)
    }

    private func setupDishPhotoImageViewConstraints() {
        dishPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dishPhotoImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),
            dishPhotoImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 15
            ),
            dishPhotoImageView.heightAnchor.constraint(equalToConstant: 80),
            dishPhotoImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupDishDescriptionLabelConstraints() {
        dishDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dishDescriptionLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 22
            ),
            dishDescriptionLabel.leadingAnchor.constraint(
                equalTo: dishPhotoImageView.trailingAnchor,
                constant: 20
            ),
            dishDescriptionLabel.widthAnchor.constraint(equalToConstant: 197)
        ])
    }
}

// MARK: - Extension

extension DetailTableViewCell {
    func configure(dish: Dish) {
        dishPhotoImageView.image = UIImage(named: dish.foodImage)
        dishDescriptionLabel.text = dish.foodDescription
    }
}
