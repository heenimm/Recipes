// PersonalInfoCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol PersonalInfoCellDelegate: AnyObject {
    func didTapChangePersonalInfoButton()
}

/// ячейка отображения персональных данных
final class PersonalInfoCell: UITableViewCell {
    
    private enum Constants {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let pencil = "pencil"
        static let leftInset = UIScreen.main.bounds.width / 2 - 80
    }
    
    // MARK: - Static Constant

    static let reuseID = String(describing: PersonalInfoCell.self)

    weak var delegate: PersonalInfoCellDelegate?

    // MARK: - Visual Components

    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 80
        imageView.clipsToBounds = true
        return imageView
    }()

    private let changeNameBotton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.setImage(UIImage(named: Constants.pencil), for: .normal)
        button.addTarget(self, action: #selector(changePersonalInfo), for: .touchUpInside)
        return button
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel(frame: CGRect(
            x: 51,
            y: 222,
            width: 256,
            height: 50
        ))
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 28)
        return label
    }()

    // MARK: - Life Cycle

    override func didMoveToSuperview() {
        setupSubviews()
        setupUserPhotoImageViewConstraints()
        setupChangeNameImageViewConstraints()
        setupUserNameLabelConstraints()
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        contentView.addSubview(userPhotoImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(changeNameBotton)
    }

    private func setupUserPhotoImageViewConstraints() {
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            userPhotoImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.leftInset
            ),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 160),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 160)

        ])
    }

    private func setupChangeNameImageViewConstraints() {
        changeNameBotton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeNameBotton.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 222
            ),
            changeNameBotton.leadingAnchor.constraint(
                equalTo: userNameLabel.trailingAnchor,
                constant: 8

            ),
            changeNameBotton.heightAnchor.constraint(equalToConstant: 24),
            changeNameBotton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func setupUserNameLabelConstraints() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 222
            ),
            userNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 51
            ),
            userNameLabel.heightAnchor.constraint(equalToConstant: 30),
            userNameLabel.widthAnchor.constraint(equalToConstant: 256)
        ])
    }

    @objc private func changePersonalInfo() {
        delegate?.didTapChangePersonalInfoButton()
    }
}

// MARK: - Extension

extension PersonalInfoCell {
    func configure(_ infoPersonal: InfoPersonal) {
        userPhotoImageView.image = UIImage(named: infoPersonal.userPhoto)
        userNameLabel.text = infoPersonal.userName
    }
}
