// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контейнер для проставления зависимостей  и сборки модуля
class AppBuilder {
    func makeProfileModule() -> ProfileViewController {
        let view = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: view)
        view.presenter = profilePresenter
        view.tabBarItem = UITabBarItem(title: "Recipe", image: UIImage(systemName: "homekit"), tag: 0)
        return view
    }
}

/// Главный координатор
final class AppCoordinator: BaseCoordinator {
    private var tabBarViewController: MainTabBarViewController?
    private var appBuilder = AppBuilder()

    override func start() {
        if "admin" == "admin" {
            toMain()
        } else {
            toAuth()
        }
    }

    private func toMain() {
        tabBarViewController = MainTabBarViewController()
    }

    private func toAuth() {
        let authCoordinator = AuthCoordinator()
        authCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: authCoordinator)
            self?.toMain()
        }
        add(coordinator: authCoordinator)
        authCoordinator.start()
    }
}
