// FavoriteViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class FavoriteViewController: UIViewController {
    // MARK: - Enums

    private enum Constants {
        static let titleText = "Favorites"
    }

    // MARK: - Public Properties

    weak var presenter: FavoritePresenter?
    private var favorites = Favorite.favorites

    // MARK: - Visual Components

    private var favoriteTableView: UITableView!
    private lazy var nothingYetView = NothingYetView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationItem()
        setupNothingViewConstraints()
    }

    // MARK: - Private Methods

    private func setupNavigationItem() {
        let label = UILabel()
        label.text = Constants.titleText
        label.sizeToFit()
        label.font = .VerdanaBold28
        let leftItem = UIBarButtonItem(customView: label)
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    private func setupTableView() {
        favoriteTableView = UITableView()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.backgroundColor = .white
        favoriteTableView.rowHeight = UITableView.automaticDimension
        favoriteTableView.estimatedRowHeight = UITableView.automaticDimension
        favoriteTableView.cellLayoutMarginsFollowReadableWidth = true
        favoriteTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        favoriteTableView.separatorStyle = .none
        favoriteTableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseID)
        view.addSubview(favoriteTableView)

        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupNothingViewConstraints() {
        view.addSubview(nothingYetView)
        nothingYetView.isHidden = true
        nothingYetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nothingYetView.topAnchor.constraint(equalTo: view.topAnchor),
            nothingYetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nothingYetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nothingYetView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc private func backToRecipes() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension FavoriteViewController + UITableViewDelegate

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        if favorites.count == 0 {
            tableView.isHidden = true
            nothingYetView.isHidden = false
        }
    }
}

// MARK: - Extension FavoriteViewController + UITableViewDataSource

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteTableView.dequeueReusableCell(
            withIdentifier: FavoriteTableViewCell.reuseID,
            for: indexPath
        ) as? FavoriteTableViewCell else { return UITableViewCell() }
        cell.configure(favorite: favorites[indexPath.row])
        return cell
    }
}
