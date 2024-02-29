// RecipesCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
    // MARK: - Types

    // MARK: - Constants

    enum Constants {
        static let verdana20 = UIFont(name: "Verdana", size: 20)
    }

    // MARK: - IBOutlets

    // MARK: - Visual Components

    var recipesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.alpha = 0.82
        return view
    }()

    var footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.verdana20
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    // MARK: - Public Methods

    // MARK: - IBAction

    // MARK: - Private Methods

    private func setupUI() {
        configureCellLayer()
        contentView.addSubview(recipesImageView)
        contentView.addSubview(footerView)
        contentView.addSubview(footerLabel)
        NSLayoutConstraint.activate([
            recipesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipesImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            footerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            footerLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            footerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func configureCellLayer() {
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
    }
}
