// RecipesCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
    // MARK: - Types

    // MARK: - Constants

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

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
//            setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    // MARK: - Public Methods

    // MARK: - IBAction

    // MARK: - Private Methods

    ////    private func setupUI() {
//        clipsToBounds = true
//        contentView.addSubview(photoImageView)
//        photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
}
