// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью экрана рецептов
final class RecipesViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let recipesTitle = "Recipes"
        static let verdanaBold16 = UIFont(name: "Verdana-Bold", size: 16)
        static let verdanaBold26 = UIFont(name: "Verdana-Bold", size: 26)
        static let verdanaBold24 = UIFont(name: "Verdana-Bold", size: 24)
        static let verdanaBold28 = UIFont(name: "Verdana-Bold", size: 28)
        static let verdanaBold18 = UIFont(name: "Verdana-Bold", size: 18)
        static let verdanaBold12 = UIFont(name: "Verdana-Bold", size: 12)
        static let verdana18 = UIFont(name: "Verdana", size: 18)
        static let verdana14 = UIFont(name: "Verdana", size: 14)
        static let verdana16 = UIFont(name: "Verdana", size: 16)
        static let recipesCell = "RecipesCollectionViewCell"
    }

    // MARK: - Visual Components

    private var recipesCollectionView: UICollectionView!

    // MARK: - Public Properties

    var presenter: RecipesPresenter?
    let invoker = Invoker()
    let openRecipesScreenCommand = LogUserActionCommand(action: "Пользователь открыл 'Экран рецептов'")

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        invoker.addCommand(openRecipesScreenCommand)
        invoker.executeCommands()
        AnalyticsLogger.shared.saveLogToFile()
        configureUI()
    }

    // MARK: - Private Methods

    private func setupCollectionView() {
        recipesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        recipesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipesCollectionView)
        recipesCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        recipesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        recipesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recipesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recipesCollectionView.dataSource = self
        recipesCollectionView.delegate = self
        recipesCollectionView.register(
            RecipesCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.recipesCell
        )
    }

    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        return layout
    }

    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationItem()
        setupCollectionView()
    }

    private func configureNavigationItem() {
        let titleLabel = UILabel()
        titleLabel.text = Constants.recipesTitle
        titleLabel.font = Constants.verdanaBold28
        titleLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
}

extension RecipesViewController: RecipesCollectionViewCellDelegate {
    func recipesCellDidTap(_ cell: RecipesCollectionViewCell) {
        if let detailTableView = presenter?.recipesCoordinator?.showDetailScreen() {
            detailTableView.dishType = cell.dishType
            detailTableView.titleText = cell.footerLabel.text
            navigationController?.pushViewController(detailTableView, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.recipes.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.recipesCell,
            for: indexPath
        ) as?
            RecipesCollectionViewCell else { return UICollectionViewCell() }

        cell.delegate = self
        cell.recipesImageView.image = presenter?.recipes[indexPath.item].image
        cell.footerLabel.text = presenter?.recipes[indexPath.item].name
        cell.dishType = presenter?.recipes[indexPath.item].dishType
        cell.layer.cornerRadius = 15.0
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

/// Определение функций из протокола UICollectionViewDelegateFlowLayout
extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        presenter?.chooseSizeCell(indexPath) ?? CGSize(width: 110, height: 110)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 7, bottom: 0, right: 7)
    }
}

// MARK: - RecipesViewProtocol

/// Определение функций из протокола RecipesViewProtocol
extension RecipesViewController: RecipesViewProtocol {
    func setCellSize(_ size: CGSize) -> CGSize {
        size
    }
}
