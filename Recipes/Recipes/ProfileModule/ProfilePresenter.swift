// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер профиля пользователя
final class ProfilePresenter {
    // MARK: - Public Properties

    weak var profileCoordinator: ProfileCoordinator?

    // MARK: - Private Properties

    private weak var view: ProfileViewController?

    private var records: [InfoPersonal] = []
    private let infoPersonalCaretaker = InfoPersonalCaretaker()
    private var infoPersonal = InfoPersonal(userPhoto: "userImage", userName: "Surname Name")
//    private var storageInfoPersonal = InfoPersonal.getInfoPersonals()

    // MARK: - Init

    init(view: ProfileViewController) {
        self.view = view
        infoPersonal = infoPersonalCaretaker.retrievePersonalData().first ?? InfoPersonal(
            userPhoto: "userImage",
            userName: "Surname Name"
        )
    }

    // MARK: - Public Methods

    func didSelectCell(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0: view?.bonusesBottom()
        case 1: view?.termsBottom()
        case 2: profileCoordinator?.logOut()
        default:
            break
        }
    }

    func saveUsername(_ userName: String) {
        infoPersonal.userName = userName
        records = [infoPersonal]
        infoPersonalCaretaker.save(records: records)
    }

    func loadInfoPersonal() -> [InfoPersonal] {
        infoPersonal = infoPersonalCaretaker.retrievePersonalData().first ?? InfoPersonal(
            userPhoto: "userImage",
            userName: "Surname Name"
        )
        records = [infoPersonal]
        return records
//        storageInfoPersonal = records
    }
}
