// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер профиля пользователя
final class RecipesPresenter {
    // MARK: - Public Properties

    weak var recipesCoordinator: RecipesCoordinator?

    // MARK: - Private Properties

    private weak var view: RecipesViewController?

    // MARK: - Init

    init(view: RecipesViewController) {
        self.view = view
    }

    // MARK: - Public Methods

//    func didSelectCell(at indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0: view?.bonusesBottom()
//        case 1: view?.termsBottom()
//        case 2: print(2)
//        default:
//            break
//        }
//    }
}
