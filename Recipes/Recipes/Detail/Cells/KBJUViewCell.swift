// KBJUViewCell.swift
// Copyright © RoadMap. All rights reserved.

//// KBJUViewCell.swift
//// Copyright © RoadMap. All rights reserved.
//
import UIKit

final class KBJUViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let kcalTitleText = "Enerc kcal"
        static let kcalText = "1322 kcal"
        static let carbohidTitleText = "Carbohydrates"
        static let carbohidText = "10,78 g"
        static let fatsTitleText = "Fats"
        static let fatsText = "10,00 g"
        static let proteinsTitleText = "Fats"
        static let proteinsText = "10,00 g"
        static let verdanaBold18 = UIFont(name: "Verdana-Bold", size: 18)
        static let verdanaBold16 = UIFont(name: "Verdana-Bold", size: 16)
        static let verdanaBold20 = UIFont(name: "Verdana-Bold", size: 20)
        static let verdanaBold26 = UIFont(name: "Verdana-Bold", size: 26)
        static let verdanaBold12 = UIFont(name: "Verdana-Bold", size: 12)
        static let verdanaBold10 = UIFont(name: "Verdana-Bold", size: 10)
        static let verdanaBold14 = UIFont(name: "Verdana-Bold", size: 14)
        static let verdana16 = UIFont(name: "Verdana", size: 16)
        static let verdana14 = UIFont(name: "Verdana", size: 14)
        static let verdana12 = UIFont(name: "Verdana", size: 12)
        static let verdana10 = UIFont(name: "Verdana", size: 10)
        static let verdana8 = UIFont(name: "Verdana", size: 8)
    }

    // MARK: - Visual Components

    private let insideView: UIView = .init()
    private let kcalView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = CGColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 1)
        return imageView
    }()

    private let kcalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.kcalTitleText
        label.font = Constants.verdana10
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .appPictureView
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let kcalLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.kcalText
        label.font = Constants.verdana10
        label.textAlignment = .center
        label.textColor = .appPictureView
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let carbohidView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = CGColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 1)
        return imageView
    }()

    private let carbohidTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.carbohidTitleText
        label.font = Constants.verdana8
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .appPictureView
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let carbohidLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.carbohidText
        label.font = Constants.verdana10
        label.textAlignment = .center
        label.textColor = .appPictureView
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let fatsView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = CGColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 1)
        return imageView
    }()

    private let fatsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.fatsTitleText
        label.font = Constants.verdana10
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .appPictureView
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let fatsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.fatsText
        label.font = Constants.verdana10
        label.textAlignment = .center
        label.textColor = .appPictureView
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let proteinsView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = CGColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 1)
        return imageView
    }()

    private let proteinsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.proteinsTitleText
        label.font = Constants.verdana10
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .appPictureView
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let proteinsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.proteinsText
        label.font = Constants.verdana10
        label.textAlignment = .center
        label.textColor = .appPictureView
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

    private func setSecondViewConstraint() {
        NSLayoutConstraint.activate([
            carbohidView.leadingAnchor.constraint(equalTo: kcalView.trailingAnchor, constant: 5),
            carbohidView.topAnchor.constraint(equalTo: insideView.topAnchor, constant: 20),
            carbohidView.bottomAnchor.constraint(equalTo: insideView.bottomAnchor),
            carbohidView.heightAnchor.constraint(equalToConstant: 53),
            carbohidView.widthAnchor.constraint(equalToConstant: 74),

            carbohidTitleLabel.leadingAnchor.constraint(equalTo: carbohidView.leadingAnchor),
            carbohidTitleLabel.topAnchor.constraint(equalTo: carbohidView.topAnchor),
            carbohidTitleLabel.trailingAnchor.constraint(equalTo: carbohidView.trailingAnchor),
            carbohidTitleLabel.heightAnchor.constraint(equalToConstant: 31),

            carbohidLabel.leadingAnchor.constraint(equalTo: carbohidView.leadingAnchor),
            carbohidLabel.topAnchor.constraint(equalTo: carbohidTitleLabel.bottomAnchor),
            carbohidLabel.trailingAnchor.constraint(equalTo: carbohidView.trailingAnchor),
            carbohidLabel.heightAnchor.constraint(equalToConstant: 22)

        ])
    }

    private func setThridViewConstraint() {
        NSLayoutConstraint.activate([
            fatsView.leadingAnchor.constraint(equalTo: carbohidView.trailingAnchor, constant: 5),
            fatsView.topAnchor.constraint(equalTo: insideView.topAnchor, constant: 20),
            fatsView.bottomAnchor.constraint(equalTo: insideView.bottomAnchor),
            fatsView.heightAnchor.constraint(equalToConstant: 53),
            fatsView.widthAnchor.constraint(equalToConstant: 74),

            fatsTitleLabel.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor),
            fatsTitleLabel.topAnchor.constraint(equalTo: fatsView.topAnchor),
            fatsTitleLabel.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor),
            fatsTitleLabel.heightAnchor.constraint(equalToConstant: 31),

            fatsLabel.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor),
            fatsLabel.topAnchor.constraint(equalTo: fatsTitleLabel.bottomAnchor),
            fatsLabel.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor),
            fatsLabel.heightAnchor.constraint(equalToConstant: 22)

        ])
    }

    private func setFourthViewConstraint() {
        NSLayoutConstraint.activate([
            proteinsView.leadingAnchor.constraint(equalTo: fatsView.trailingAnchor, constant: 5),
            proteinsView.topAnchor.constraint(equalTo: insideView.topAnchor, constant: 20),
            proteinsView.bottomAnchor.constraint(equalTo: insideView.bottomAnchor),
            proteinsView.heightAnchor.constraint(equalToConstant: 53),
            proteinsView.widthAnchor.constraint(equalToConstant: 74),

            proteinsTitleLabel.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor),
            proteinsTitleLabel.topAnchor.constraint(equalTo: proteinsView.topAnchor),
            proteinsTitleLabel.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor),
            proteinsTitleLabel.heightAnchor.constraint(equalToConstant: 31),

            proteinsLabel.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor),
            proteinsLabel.topAnchor.constraint(equalTo: proteinsTitleLabel.bottomAnchor),
            proteinsLabel.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor),
            proteinsLabel.heightAnchor.constraint(equalToConstant: 22)

        ])
    }

    private func setFirstViewConstraint() {
        NSLayoutConstraint.activate([
            insideView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            insideView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            insideView.topAnchor.constraint(equalTo: contentView.topAnchor),
            insideView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            kcalView.leadingAnchor.constraint(equalTo: insideView.leadingAnchor, constant: 40),
            kcalView.topAnchor.constraint(equalTo: insideView.topAnchor, constant: 20),
            kcalView.bottomAnchor.constraint(equalTo: insideView.bottomAnchor),
            kcalView.heightAnchor.constraint(equalToConstant: 53),
            kcalView.widthAnchor.constraint(equalToConstant: 74),

            kcalTitleLabel.leadingAnchor.constraint(equalTo: kcalView.leadingAnchor),
            kcalTitleLabel.topAnchor.constraint(equalTo: kcalView.topAnchor),
            kcalTitleLabel.trailingAnchor.constraint(equalTo: kcalView.trailingAnchor),
            kcalTitleLabel.heightAnchor.constraint(equalToConstant: 31),

            kcalLabel.leadingAnchor.constraint(equalTo: kcalView.leadingAnchor),
            kcalLabel.topAnchor.constraint(equalTo: kcalTitleLabel.bottomAnchor),
            kcalLabel.trailingAnchor.constraint(equalTo: kcalView.trailingAnchor),
            kcalLabel.heightAnchor.constraint(equalToConstant: 22)

        ])
    }

    private func setConstraint() {
        setFirstViewConstraint()
        setSecondViewConstraint()
        setThridViewConstraint()
        setFourthViewConstraint()
    }

    private func setupCell() {
        insideView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(insideView)
        insideView.addSubview(kcalView)
        kcalView.addSubview(kcalTitleLabel)
        kcalView.addSubview(kcalLabel)

        insideView.addSubview(carbohidView)
        carbohidView.addSubview(carbohidTitleLabel)
        carbohidView.addSubview(carbohidLabel)

        insideView.addSubview(fatsView)
        fatsView.addSubview(fatsTitleLabel)
        fatsView.addSubview(fatsLabel)

        insideView.addSubview(proteinsView)
        proteinsView.addSubview(proteinsTitleLabel)
        proteinsView.addSubview(proteinsLabel)

        setConstraint()
    }
}
