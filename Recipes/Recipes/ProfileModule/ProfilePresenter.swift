// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
protocol ProfilePresenterDelegate: AnyObject {}

/// Презентер профиля пользователя
final class ProfilePresenter {
    // MARK: - Public Properties

    weak var profileCoordinator: ProfileCoordinator?

    // MARK: - Private Properties

    private weak var view: ProfileViewController?

    // MARK: - Init

    init(view: ProfileViewController) {
        self.view = view
    }

    // MARK: - Public Methods
    func didSelectCell(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0: print(0)
        case 1: view?.termsActionSheet()
        case 2: print(2)
        default:
            break
        }
    }
}
