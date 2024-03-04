// DescriptionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class DescriptionViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let verdana14 = UIFont(name: "Verdana", size: 14)
        static let descriptionText = """
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green Thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium-size Asian eggplants, cut into 1-inch rounds
        Handful of bird's eye chilies
        1/2 cup Thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green Thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium-size Asian eggplants, cut into 1-inch rounds
        Handful of bird's eye chilies
        1/2 cup Thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green Thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium-size Asian eggplants, cut into 1-inch rounds
        Handful of bird's eye chilies
        1/2 cup Thai basil leaves
        Juice of 3 limes
        """
    }

    // MARK: - Visual Components

    private let insideView: UIView = .init()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.descriptionText
        label.font = Constants.verdana14
        label.textColor = .black
        label.numberOfLines = 0
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

    private func addGradientToView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.appDescription.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 3)
        gradientLayer.frame = insideView.bounds
        insideView.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupCell() {
        insideView.translatesAutoresizingMaskIntoConstraints = false
        insideView.backgroundColor = .appDescription
        insideView.layer.cornerRadius = 20
        contentView.addSubview(insideView)
        insideView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            insideView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            insideView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            insideView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            insideView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15),

            descriptionLabel.leadingAnchor.constraint(equalTo: insideView.leadingAnchor, constant: 27),
            descriptionLabel.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: -27),
            descriptionLabel.topAnchor.constraint(equalTo: insideView.topAnchor, constant: 27),
            descriptionLabel.bottomAnchor.constraint(equalTo: insideView.bottomAnchor, constant: -15)
        ])
        addGradientToView()
    }
}
