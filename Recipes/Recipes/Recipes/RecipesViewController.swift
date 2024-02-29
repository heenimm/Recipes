// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class RecipesViewController: UIViewController {
    // MARK: - Constants

    /// Типы ячеек
    enum TypeCells {
        /// Маленькая ячейка рецептов
        case small
        /// Средняя ячейка рецептов
        case medium
        /// Большая ячейка рецептов
        case big
    }

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

    // MARK: - IBOutlets

    // MARK: - Visual Components

    private var recipesCollectionView: UICollectionView!

    // MARK: - Public Properties

    var presenter: RecipesPresenter?

    // MARK: - Private Properties

    private let typesCells: [TypeCells] = [.medium, .medium, .big, .small, .small, .small, .big, .medium, .medium]
    private let recipes: [Recipes] = Recipes.allRecipes()

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
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
//        recipesCollectionView.delegate = self
        recipesCollectionView.register(
            RecipesCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.recipesCell
        )
    }

    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
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

    // MARK: - Public Methods

    // MARK: - IBAction

    // MARK: - Private Methods
}

// MARK: - UICollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
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

//        cell.photoImageView.image = UIImage(named: photos[indexPath.item].imageName)
        return cell
    }
}
