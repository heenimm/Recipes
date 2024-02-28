// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контейнер для проставления зависимостей  и сборки модуля
class AppBuilder {
    func makeProfileModule() -> ProfileViewController {
        let view = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: view)
        view.presenter = profilePresenter
        view.tabBarItem = UITabBarItem(
            title: "Profile",

            image: UIImage(systemName: "smiley.fill")?.withTintColor(
                UIColor(
                    named: "AppGreen"
                )!,
                renderingMode: .alwaysOriginal
            ),
            tag: 0
        )
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
        /// Set profile
        let profileView = appBuilder.makeProfileModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileView)
        profileView.presenter?.profileCoordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        profileCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: profileCoordinator)
            self?.tabBarViewController = nil
            self?.toAuth()
        }

        tabBarViewController?.setViewControllers([profileCoordinator.rootController], animated: false)
        setAsRoot(_: tabBarViewController!)
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
