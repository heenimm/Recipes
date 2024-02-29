// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контейнер для проставления зависимостей  и сборки модуля
private class AppBuilder {
    enum Constants {
        static let profileText = "Profile"
        static let smileText = "smiley.fill"
        static let appGreenText = "AppGreen"
        static let recipesText = "Recipes"
        static let recipesImage = "recipesCake"
    }

    func makeProfileModule() -> ProfileViewController {
        let view = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: view)
        view.presenter = profilePresenter
        view.tabBarItem = UITabBarItem(
            title: Constants.profileText,

            image: UIImage(systemName: Constants.smileText)?.withTintColor(
                UIColor(
                    named: Constants.appGreenText
                )!,
                renderingMode: .alwaysOriginal
            ),
            tag: 0
        )
        return view
    }

    func makeRecipesModule() -> RecipesViewController {
        let view = RecipesViewController()
        let recipesPresenter = RecipesPresenter(view: view)
        view.presenter = recipesPresenter
        view.tabBarItem = UITabBarItem(
            title: Constants.recipesText,
            image: UIImage(named: Constants.recipesImage)?.withTintColor(
                UIColor(
                    named: Constants.appGreenText
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
    enum Constants {
        static let adminText = "admin"
    }

    // MARK: - Private Properties

    private var mainTabBarViewController: MainTabBarViewController?
    private var appBuilder = AppBuilder()

    // MARK: - Life Cycle

    override func start() {
        if Constants.adminText == Constants.adminText {
            toMain()
        } else {
            toAuth()
        }
    }

    // MARK: - Private Methods

    private func toMain() {
        mainTabBarViewController = MainTabBarViewController()
        /// Set profile
        let profileView = appBuilder.makeProfileModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileView)
        profileView.presenter?.profileCoordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        profileCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: profileCoordinator)
            self?.mainTabBarViewController = nil
            self?.toAuth()
        }

        /// Set recipes
        let recipesView = appBuilder.makeRecipesModule()
        let recipesCoordinator = RecipesCoordinator(rootController: recipesView)
        recipesView.presenter?.recipesCoordinator = recipesCoordinator
        add(coordinator: recipesCoordinator)

        recipesCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: recipesCoordinator)
            self?.mainTabBarViewController = nil
            self?.toAuth()
        }

        mainTabBarViewController?.setViewControllers(
            [recipesCoordinator.rootController, profileCoordinator.rootController],
            animated: false
        )
        setAsRoot(_: mainTabBarViewController!)
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
