// FavoriteCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана избранное
final class FavoriteCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController
    var onFinishFlow: (() -> Void)?

    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    func logOut() {
        onFinishFlow?()
    }
}
