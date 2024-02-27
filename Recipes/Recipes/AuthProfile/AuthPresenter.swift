// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AuthView {
//    func setGreeting(greeting: String)
}

protocol AuthViewPresenter {
//    init(view: GreetingView, person: Person)
//    func showGreeting()
}

/// Презентер окна авторизации
final class AuthPresenter: AuthViewPresenter {
    weak var authCoordinator: AuthCoordinator?

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}
