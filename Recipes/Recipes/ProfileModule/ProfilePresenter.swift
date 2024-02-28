// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
protocol ProfilePresenterDelegate: AnyObject {}

/// Презентер профиля пользователя
final class ProfilePresenter {
    // MARK: -

    weak var profileCoordinator: ProfileCoordinator?

    // MARK: -

    private weak var view: ProfileViewController?

    // MARK: -

    init(view: ProfileViewController) {
        self.view = view
    }

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
