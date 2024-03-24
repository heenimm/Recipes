// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана рецептов
final class RecipesCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController
    var onFinishFlow: (() -> Void)?

    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    // MARK: - Public Methods

    func showDetailScreen() -> DetailViewController {
        let detailViewController = DetailViewController()
        let detailPresenter = DetailPresenter(view: detailViewController)
        detailViewController.presenter = detailPresenter
        detailViewController.networkService = NetworkService()
        detailPresenter.detailCoordinator = self
        return detailViewController
    }

    func logOut() {
        onFinishFlow?()
    }
}
