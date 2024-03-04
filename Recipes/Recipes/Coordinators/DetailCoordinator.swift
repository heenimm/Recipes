// DetailCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class DetailCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootViewController: DetailViewController!
    var onFinishFlow: (() -> Void)?

    // MARK: - Initializers

    init(rootViewController: DetailViewController) {
        self.rootViewController = rootViewController
    }

    func showDetailScreen() -> DetailViewController {
        let detailViewController = DetailViewController()
        let detailPresenter = DetailPresenter(view: detailViewController)
        detailViewController.presenter = detailPresenter
        detailPresenter.detailCoordinator = self
        return detailViewController
    }

    func logOut() {
        onFinishFlow?()
    }
}
