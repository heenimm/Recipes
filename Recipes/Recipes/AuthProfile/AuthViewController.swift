// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Окно авторизации в приложении
final class AuthViewController: UIViewController {
    var presenter: AuthPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
