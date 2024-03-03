// NothingYetView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Окон которое показывается если нет избранных рецептов
final class NothingYetView: UIView {
    // MARK: - Enums

    private enum Constants {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let infoLabelText = "There's nothing here yet"
        static let descriptionLabelText = "Add interesting recipes to make ordering products convenient"
        static let mark = "mark"
        static let markBackground = "AppMarkBackground"
    }

    // MARK: - Visual Components

    private let markImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: Constants.mark)
        imageView.backgroundColor = UIColor(named: Constants.markBackground)
        imageView.clipsToBounds = true
        return imageView
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 18)
        label.text = Constants.infoLabelText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.text = Constants.descriptionLabelText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Life Cycle

    override func didMoveToSuperview() {
        backgroundColor = .white
        setupSubviews()
        setupDishPhotoImageViewConstraints()
        setupInfoLabelConstraints()
        setupDescriptionLabelConstraints()
    }

    private func setupSubviews() {
        addSubview(markImageView)
        addSubview(infoLabel)
        addSubview(descriptionLabel)
    }

    private func setupDishPhotoImageViewConstraints() {
        markImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            markImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            markImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            markImageView.heightAnchor.constraint(equalToConstant: 50),
            markImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupInfoLabelConstraints() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: markImageView.bottomAnchor, constant: 10),
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 35),
            infoLabel.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    private func setupDescriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 35),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
}
