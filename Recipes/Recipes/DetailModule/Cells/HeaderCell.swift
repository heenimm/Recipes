// HeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class HeaderCell: UITableViewHeaderFooterView {
    //
    private enum Constants {
        static let placeholderText = "Search recipes"
        static let barColor = "AppSearchColor"
    }

    // MARK: - Static Constant

    static let reuseID = String(describing: HeaderCell.self)
    override func didMoveToSuperview() {
        contentView.addSubview(searhBar)
        setupConstraints()
    }

    let label: UILabel = .init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

    private let searhBar = {
        let searhBar = UISearchBar()
        searhBar.searchTextField.borderStyle = .none
        searhBar.searchBarStyle = .minimal
        searhBar.searchTextField.backgroundColor = UIColor(named: Constants.barColor)
        searhBar.searchTextField.layer.cornerRadius = 12
        searhBar.placeholder = Constants.placeholderText
        searhBar.translatesAutoresizingMaskIntoConstraints = false
        return searhBar
    }()

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searhBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            searhBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            searhBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searhBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
