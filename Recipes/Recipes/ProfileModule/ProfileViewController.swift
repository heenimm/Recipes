// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Просмотр профиля пользователя
final class ProfileViewController: UIViewController {
    var presenter: ProfilePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
