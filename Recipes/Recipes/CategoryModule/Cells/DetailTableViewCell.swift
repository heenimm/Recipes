// DetailTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol DetailTableViewCellDelegate: AnyObject {
    func recipesCellDidTap(_ cell: DetailTableViewCell)
}

/// Состояния шиммера
protocol ShimmerStateProtocol {
    /// Включенный шиммер
    func enableShimmer()
    /// Выключенный шиммер
    func disableShimmer()
}

/// Описание состояний шиммера
final class ShimmerState: ShimmerStateProtocol {
    // MARK: - Constants

    enum Constants {
        static let locations = "locations"
        static let shimmerAnimation = "shimmerAnimation"
    }

    // MARK: - Visual Components

    private let view: UIView

    // MARK: - Private Properties

    private let gradientLayer = CAGradientLayer()

    // MARK: - Initializers

    init(view: UIView) {
        self.view = view
    }

    // MARK: - Public Methods

    func enableShimmer() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 355, height: 100)
        gradientLayer.cornerRadius = view.bounds.width / 20
        gradientLayer.colors = [
            UIColor(white: 0.8, alpha: 1.0).cgColor,
            UIColor.white.cgColor,
            UIColor(white: 0.8, alpha: 1.0).cgColor
        ]

        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        view.layer.addSublayer(gradientLayer)

        let animation = CABasicAnimation(keyPath: Constants.locations)
        animation.duration = 2.0
        animation.fromValue = [0.0, 0.2, 0.4]
        animation.toValue = [0.6, 0.8, 1.0]
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: Constants.shimmerAnimation)
    }

    func disableShimmer() {
        gradientLayer.removeFromSuperlayer()
    }
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

//        setShimmer()
    }

    // MARK: - Private Methods

    private func setShimmer() {
        let shimmerManager = ShimmerState(view: contentView)
        shimmerManager.enableShimmer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            shimmerManager.disableShimmer()
        }
    }

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
    func configure(dish: Recipe) {
        if let imageURL = URL(string: dish.foodImage),
           let imageData = try? Data(contentsOf: imageURL),
           let image = UIImage(data: imageData)
        {
            dishPhotoImageView.image = image
        } else {
            dishPhotoImageView.image = nil
        }

//        dishPhotoImageView.image = UIImage(named: dish.foodImage)
        dishDescriptionLabel.text = dish.foodDescription
        dishTimeLabel.text = String(dish.cookingTime) + " min"
        dishCaloriesLabel.text = String(dish.caloriesСontent)
    }
}
