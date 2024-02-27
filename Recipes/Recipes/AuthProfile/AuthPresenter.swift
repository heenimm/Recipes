// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер окна авторизации
final class AuthPresenter {
    weak var authCoordinator: AuthCoordinator?

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}
