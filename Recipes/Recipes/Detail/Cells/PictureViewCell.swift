// PictureViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с картинкой
final class PictureViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let detailPicture = "detailPicture"
        static let detailText = "Simple Fish And Corn"
        static let bagText = "793 g"
        static let bagPicture = "bagImage"
        static let cookingText = "Cooking time"
        static let cookingTimeText = "60 min"
        static let cookingTimePicture = "cookingTimeImage"
    }

    // MARK: - Visual Components

    private let insideView: UIView = .init()
    private let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.detailPicture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.detailText
        label.font = .VerdanaBold20
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bagView: UIView = {
        let view = UIView()
        view.backgroundColor = .appPictureView
        view.alpha = 0.9
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.bagPicture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bagLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.bagText
        label.font = .Verdana10
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cookingTimeView: UIView = {
        let view = UIView()
        view.backgroundColor = .appPictureView
        view.alpha = 0.9
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private let cookingTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.cookingTimePicture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let cookingLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.cookingText
        label.font = .Verdana10
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.cookingTimeText
        label.font = .Verdana10
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setBagView() {
        NSLayoutConstraint.activate([
            bagView.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: -6),
            bagView.topAnchor.constraint(equalTo: pictureImageView.topAnchor, constant: 8),
            bagView.widthAnchor.constraint(equalToConstant: 50),
            bagView.heightAnchor.constraint(equalToConstant: 50),

            bagImageView.leadingAnchor.constraint(equalTo: bagView.leadingAnchor, constant: 15),
            bagImageView.trailingAnchor.constraint(equalTo: bagView.trailingAnchor, constant: -15),
            bagImageView.topAnchor.constraint(equalTo: bagView.topAnchor, constant: 7),
            bagImageView.bottomAnchor.constraint(equalTo: bagView.bottomAnchor, constant: -26),

            bagLabel.leadingAnchor.constraint(equalTo: bagView.leadingAnchor, constant: 6),
            bagLabel.trailingAnchor.constraint(equalTo: bagView.trailingAnchor, constant: -10),
            bagLabel.topAnchor.constraint(equalTo: bagView.topAnchor, constant: 28),
            bagLabel.bottomAnchor.constraint(equalTo: bagView.bottomAnchor, constant: -6),
        ])
    }

    private func setCookingTimeView() {
        NSLayoutConstraint.activate([
            cookingTimeView.leadingAnchor.constraint(equalTo: pictureImageView.leadingAnchor, constant: 176),
            cookingTimeView.bottomAnchor.constraint(equalTo: pictureImageView.bottomAnchor),
            cookingTimeView.widthAnchor.constraint(equalToConstant: 140),
            cookingTimeView.heightAnchor.constraint(equalToConstant: 48),

            cookingTimeImageView.leadingAnchor.constraint(equalTo: cookingTimeView.leadingAnchor, constant: 8),
            cookingTimeImageView.topAnchor.constraint(equalTo: cookingTimeView.topAnchor, constant: 12),
            cookingTimeImageView.bottomAnchor.constraint(equalTo: cookingTimeView.bottomAnchor, constant: -11),
            cookingTimeImageView.widthAnchor.constraint(equalToConstant: 25),

            cookingLabel.leadingAnchor.constraint(equalTo: cookingTimeImageView.trailingAnchor),
            cookingLabel.topAnchor.constraint(equalTo: cookingTimeView.topAnchor, constant: 10),
            cookingLabel.widthAnchor.constraint(equalToConstant: 83),
            cookingLabel.heightAnchor.constraint(equalToConstant: 15),

            cookingTimeLabel.leadingAnchor.constraint(equalTo: cookingTimeImageView.trailingAnchor, constant: 15),
            cookingTimeLabel.topAnchor.constraint(equalTo: cookingLabel.bottomAnchor),
            cookingTimeLabel.widthAnchor.constraint(equalToConstant: 50),
            cookingTimeLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setConstraint() {
        NSLayoutConstraint.activate([
            insideView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            insideView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            insideView.topAnchor.constraint(equalTo: contentView.topAnchor),
            insideView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: insideView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: insideView.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),

            pictureImageView.leadingAnchor.constraint(equalTo: insideView.leadingAnchor, constant: 45),
            pictureImageView.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: -45),
            pictureImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            pictureImageView.heightAnchor.constraint(equalTo: pictureImageView.widthAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: insideView.bottomAnchor)
        ])
        setBagView()
        setCookingTimeView()
    }

    private func setupCell() {
        insideView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(insideView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(pictureImageView)
        contentView.addSubview(bagView)
        bagView.addSubview(bagImageView)
        bagView.addSubview(bagLabel)

        pictureImageView.addSubview(cookingTimeView)
        cookingTimeView.addSubview(cookingTimeImageView)
        cookingTimeView.addSubview(cookingLabel)
        cookingTimeView.addSubview(cookingTimeLabel)

        setConstraint()
    }
}
