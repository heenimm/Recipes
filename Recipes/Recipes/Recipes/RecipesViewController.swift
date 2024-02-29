// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

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

        cell.recipesImageView.image = recipes[indexPath.item].image
        cell.footerLabel.text = recipes[indexPath.item].name
        cell.layer.cornerRadius = 15.0
        ////        cell.layer.borderWidth = 0.0
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
//        cell.layer.shadowRadius = 18.0
//        cell.layer.shadowOpacity = 1
//        cell.layer.masksToBounds = false // <-

        return cell
    }
}

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch typesCells[indexPath.row] {
        case .small:
            return CGSize(width: 110, height: 110)
        case .medium:
            return CGSize(width: 175, height: 175)
        case .big:
            return CGSize(width: 250, height: 250)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 7, bottom: 0, right: 7)
    }
}
