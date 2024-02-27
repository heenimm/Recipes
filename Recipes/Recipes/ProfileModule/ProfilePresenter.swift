// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ProfilePresenterDelegate: AnyObject {}

/// Презентер профиля пользователя
final class ProfilePresenter {
    weak var profileCoordinator: ProfileCoordinator?

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}
