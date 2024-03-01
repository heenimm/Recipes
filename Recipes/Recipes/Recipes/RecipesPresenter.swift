// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для презентера view экрана авторизации
protocol RecipesViewPresenterProtocol {
    /// Выбор размера ячейки
    func chooseSizeCell(_ indexPath: IndexPath) -> CGSize
}

/// Протокол для view экрана авторизации
protocol RecipesViewProtocol {
    /// Установка размера ячейке
    func setCellSize(_ size: CGSize) -> CGSize
}

/// Презентер экрана рецептов
final class RecipesPresenter: RecipesViewPresenterProtocol {
    // MARK: - Public Properties

    weak var recipesCoordinator: RecipesCoordinator?

    // MARK: - Private Properties

    private weak var view: RecipesViewController?
    private let typesCells: [TypeCells] = [.medium, .medium, .big, .small, .small, .small, .big, .medium, .medium]
    let recipes: [Recipes] = Recipes.allRecipes()

    // MARK: - Init

    init(view: RecipesViewController) {
        self.view = view
    }

    // MARK: - Public Methods

    func chooseSizeCell(_ indexPath: IndexPath) -> CGSize {
        switch typesCells[indexPath.row] {
        case .small:
            view?.setCellSize(CGSize(width: 110, height: 110)) ?? CGSize(width: 110, height: 110)
        case .medium:
            view?.setCellSize(CGSize(width: 175, height: 175)) ?? CGSize(width: 110, height: 110)
        case .big:
            view?.setCellSize(CGSize(width: 250, height: 250)) ?? CGSize(width: 110, height: 110)
        }
    }
}
