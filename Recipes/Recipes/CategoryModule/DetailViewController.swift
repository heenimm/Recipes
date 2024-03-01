// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class DetailViewController: UIViewController {
    // MARK: - Enums

    private enum Constants {
        static let titleText = "  Fish"
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let back = "back"
    }

    // MARK: - Public Properties

    weak var presenter: DetailPresenter?

    // MARK: - Visual Components

    private var detailTableView: UITableView!
    private var dishes = Dish.allFoods()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationItem()
    }

    // MARK: - Private Methods

    private func setupNavigationItem() {
        let button = UIButton(type: .system)
        button.setTitle(Constants.titleText, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.fontVerdanaBold, size: 28)
        button.setImage(
            UIImage(named: Constants.back)?.withTintColor(.black, renderingMode: .alwaysOriginal),
            for: .normal
        )
        button.sizeToFit()
        button.addTarget(self, action: #selector(backToRecipes), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }

    private func setupTableView() {
        detailTableView = UITableView()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.backgroundColor = .white
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        detailTableView.separatorStyle = .none
        detailTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseID)
        detailTableView.tableHeaderView = HeaderCell(frame: CGRect(
            origin: .zero,
            size: CGSize(width: 100, height: 100)
        ))

        view.addSubview(detailTableView)

        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc private func backToRecipes() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension DetailViewController + UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extension DetailViewController + UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailTableView.dequeueReusableCell(
            withIdentifier: DetailTableViewCell.reuseID,
            for: indexPath
        ) as? DetailTableViewCell else { return UITableViewCell() }
        cell.configure(dish: dishes[indexPath.row])
        return cell
    }
}
