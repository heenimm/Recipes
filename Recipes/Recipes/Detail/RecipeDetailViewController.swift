// RecipeDetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class RecipeDetailViewController: UIViewController {
    // MARK: - Enums

    private enum Constants {
        static let titleText = ""
        static let pictureCell = "PictureViewCell"
        static let kbjuCell = "KBJUViewCell"
        static let descriptionCell = "DescriptionViewCell"
        static let back = "back"
        static let shareImage = "shareImage"
        static let saveImage = "saveImage"
        static let developText = "Функционал в разработке"
        static let okText = "ОК"
    }

    /// Типы ячеек
    private enum TypeCells {
        /// Ячейка с картинкой
        case picture
        /// Ячейка с КБЖУ
        case kbju
        /// Ячейка с описанием
        case descriptionCell
    }

    // MARK: - Public Properties

    weak var presenter: RecipeDetailPresenter?

    // MARK: - Visual Components

    private let typesCells: [TypeCells] = [.picture, .kbju, .descriptionCell]
    private let recipeDetailTableView: UITableView = .init()

    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.shareImage), for: .normal)
        button.tintColor = .black
        return button
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.saveImage), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(addFavorites), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureNavigationItem() {
        let button = UIButton(type: .system)
        button.setTitle(Constants.titleText, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .VerdanaBold28
        button.setImage(
            UIImage(named: Constants.back)?.withTintColor(.black, renderingMode: .alwaysOriginal),
            for: .normal
        )
        button.sizeToFit()
        button.addTarget(self, action: #selector(backToRecipes), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)

        let shareItem = UIBarButtonItem(customView: shareButton)
        let favoriteItem = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItems = [favoriteItem, shareItem]
    }

    private func configureUI() {
        configureNavigationItem()
        configureTableView()
    }

    private func configureTableView() {
        recipeDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        setupTableView()

        recipeDetailTableView.dataSource = self
        recipeDetailTableView.register(PictureViewCell.self, forCellReuseIdentifier: Constants.pictureCell)
        recipeDetailTableView.register(KBJUViewCell.self, forCellReuseIdentifier: Constants.kbjuCell)
        recipeDetailTableView.register(DescriptionViewCell.self, forCellReuseIdentifier: Constants.descriptionCell)
        recipeDetailTableView.rowHeight = UITableView.automaticDimension
        recipeDetailTableView.backgroundColor = .white
        recipeDetailTableView.separatorStyle = .none
    }

    @objc private func addFavorites() {
        let alertController = UIAlertController(title: nil, message: Constants.developText, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.okText, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @objc private func backToRecipes() {
        navigationController?.popViewController(animated: true)
    }
}

extension RecipeDetailViewController {
    func setupTableView() {
        view.addSubview(recipeDetailTableView)
        recipeDetailTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        recipeDetailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        recipeDetailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recipeDetailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: - Extension RecipeDetailViewController + UITableViewDataSource

extension RecipeDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = typesCells[indexPath.row]
        switch typeCell {
        case .picture:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.pictureCell,
                for: indexPath
            ) as? PictureViewCell
            else { fatalError() }

            return cell
        case .kbju:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.kbjuCell,
                for: indexPath
            ) as? KBJUViewCell
            else { fatalError() }
            return cell
        case .descriptionCell:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.descriptionCell,
                for: indexPath
            ) as? DescriptionViewCell
            else { fatalError() }
            return cell
        }
    }
}
