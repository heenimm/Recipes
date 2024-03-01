// HeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class HeaderCell: UITableViewHeaderFooterView {
    // MARK: - Enum

    private enum Constants {
        static let placeholderText = "Search recipes"
        static let barColor = "AppSearchColor"
        static let profileText = "Profile"
        static let smileText = "smiley.fill"
        static let greenButtonColor = "AppGreen"
        static let grayButtonColor = "AppSearchColor"
        static let upStack = "up_stack"
        static let downStack = "down_stack"
        static let timeText = "Time"
        static let caloriesText = "Calories"
    }

    // MARK: - Static Constant

    static let reuseID = String(describing: HeaderCell.self)
    override func didMoveToSuperview() {
        setupSubviews()
        setupStateButtonConstraints()
        setupSearchBarConstraints()
        setupTimeStateButtonConstraints()
    }

    // MARK: - Private

    private func setupSubviews() {
        contentView.addSubview(searchBar)
        contentView.addSubview(caloriesStateButton)
        contentView.addSubview(timeStateButton)
    }

    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = UIColor(named: Constants.barColor)
        searchBar.searchTextField.layer.cornerRadius = 12
        searchBar.placeholder = Constants.placeholderText
        return searchBar
    }()

    private let caloriesStateButton: SortingButton = {
        let button = SortingButton(type: .system)
        button.setTitle(Constants.caloriesText, for: .normal)
        button.layer.cornerRadius = 13
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: -65)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 20)
        return button
    }()

    private let timeStateButton: SortingButton = {
        let button = SortingButton(type: .system)
        button.setTitle(Constants.timeText, for: .normal)
        button.layer.cornerRadius = 13
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: -40)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 20)
        return button
    }()

    private func setupSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    private func setupStateButtonConstraints() {
        caloriesStateButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            caloriesStateButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            caloriesStateButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            caloriesStateButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            caloriesStateButton.widthAnchor.constraint(equalToConstant: 112),
            caloriesStateButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    private func setupTimeStateButtonConstraints() {
        timeStateButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            timeStateButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            timeStateButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            timeStateButton.leadingAnchor.constraint(equalTo: caloriesStateButton.trailingAnchor, constant: 10),
            timeStateButton.widthAnchor.constraint(equalToConstant: 90),
            timeStateButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
}
