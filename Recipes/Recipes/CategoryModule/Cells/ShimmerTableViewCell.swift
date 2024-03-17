// ShimmerTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер для рецептов
final class ShimmerTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let shimmerLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.lightGray.cgColor,
            UIColor.white.cgColor,
            UIColor.lightGray.cgColor
        ]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.locations = [0.35, 0.50, 0.65]
        return layer
    }()

    private let backgroundCellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.addSubview(backgroundCellView)
        backgroundCellView.layer.addSublayer(shimmerLayer)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        setContentViewConstraints()
        setBackgroundCellViewConstraints()
        shimmerLayer.frame = CGRect(x: 0, y: 0, width: 320, height: 100)

        let animation = makeAnimation()
        animation.beginTime = 0.0
        shimmerLayer.add(animation, forKey: "")
    }

    private func setContentViewConstraints() {
        contentView.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: -10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: 10).isActive = true
    }

    private func setBackgroundCellViewConstraints() {
        backgroundCellView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        backgroundCellView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        backgroundCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        backgroundCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    private func makeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.repeatCount = Float.infinity
        animation.autoreverses = false
        animation.fromValue = -frame.width
        animation.toValue = frame.width
        animation.isRemovedOnCompletion = false
        animation.fillMode = .both
        return animation
    }
}
