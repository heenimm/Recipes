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

    let label: UILabel = .init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

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

    private let caloriesStateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: Constants.grayButtonColor)
        button.titleLabel?.textColor = UIColor.black
        button.setTitle(Constants.caloriesText, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setImage(
            UIImage(named: Constants.upStack)?.withTintColor(.black, renderingMode: .alwaysOriginal),
            for: .normal
        )
        return button
    }()

    private let timeStateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: Constants.greenButtonColor)
        button.setTitle(Constants.timeText, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setImage(UIImage(named: Constants.downStack), for: .normal)
        return button
    }()

    private func setupSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10)
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
