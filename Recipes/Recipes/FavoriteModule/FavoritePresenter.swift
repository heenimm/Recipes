// FavoritePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FavoritePresenter {
    // MARK: - Private Properties

    private weak var view: FavoriteViewController?
    weak var coordinator: FavoriteCoordinator?

    // MARK: - Init

    init(view: FavoriteViewController? = nil) {
        self.view = view
    }
}
