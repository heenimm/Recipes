// DetailTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol DetailTableViewCellDelegate: AnyObject {
    func recipesCellDidTap(_ cell: DetailTableViewCell)
}

/// Виды блюд
final class DetailTableViewCell: UITableViewCell {
    // MARK: - Enums

    private enum Constants {
        static let fontVerdana = "Verdana"
        static let leftInset = UIScreen.main.bounds.width / 2 - 80
        static let next = "arrow"
    }

    // MARK: - Static Constant

    static let reuseID = String(describing: DetailTableViewCell.self)

    weak var delegate: DetailTableViewCellDelegate?

    // MARK: - Visual Components

    private let dishPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.next), for: .normal)
        button.addTarget(nil, action: #selector(cellTapped), for: .touchUpInside)
        return button
    }()

    private let dishDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.numberOfLines = 0
        return label
    }()

    private let dishTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.numberOfLines = 0
        return label
    }()

    private let dishCaloriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }

    override func didMoveToSuperview() {
        setupSubviews()
        setupDishPhotoImageViewConstraints()
        setupDishDescriptionLabelConstraints()
        setupDishTimeLabelConstraints()
        setupDishCaloriesLabelConstraints()
        setupNextButtonConstraints()
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        contentView.backgroundColor = UIColor(named: "appBottomGradient")
        contentView.layer.cornerRadius = contentView.bounds.width / 20
        contentView.addSubview(dishPhotoImageView)
        contentView.addSubview(dishDescriptionLabel)
        contentView.addSubview(dishTimeLabel)
        contentView.addSubview(dishCaloriesLabel)
        contentView.addSubview(nextButton)
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

    private func setupDishTimeLabelConstraints() {
        dishTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dishTimeLabel.topAnchor.constraint(
                equalTo: dishDescriptionLabel.topAnchor,
                constant: 40
            ),
            dishTimeLabel.leadingAnchor.constraint(
                equalTo: dishPhotoImageView.trailingAnchor,
                constant: 20
            ),
            dishTimeLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupDishCaloriesLabelConstraints() {
        dishCaloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dishCaloriesLabel.topAnchor.constraint(
                equalTo: dishDescriptionLabel.topAnchor,
                constant: 40
            ),
            dishCaloriesLabel.leadingAnchor.constraint(
                equalTo: dishTimeLabel.trailingAnchor,
                constant: 20
            ),
            dishCaloriesLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupNextButtonConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 30
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            nextButton.widthAnchor.constraint(equalToConstant: 40),
            nextButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }

    @objc private func cellTapped() {
        delegate?.recipesCellDidTap(self)
    }
}

// MARK: - Extension

extension DetailTableViewCell {
    func configure(dish: Dish) {
        dishPhotoImageView.image = UIImage(named: dish.foodImage)
        dishDescriptionLabel.text = dish.foodDescription
        dishTimeLabel.text = dish.cookingTime
        dishCaloriesLabel.text = dish.caloriesСontent
    }
}
