// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class RecipeDetailPresenter {
    // MARK: - Private Properties

    private weak var view: RecipeDetailViewController?
//    weak var coordinator: FavoriteCoordinator?

    // MARK: - Init

    init(view: RecipeDetailViewController? = nil) {
        self.view = view
    }
}
