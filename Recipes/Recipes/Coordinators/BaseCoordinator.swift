// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Главный координатор
class BaseCoordinator {
    enum Constants {
        static let childText = "child must be"
    }

    var childCoordinators: [BaseCoordinator] = []

    func start() {
        fatalError(Constants.childText)
    }

    func add(coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func remove(coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func setAsRoot(_ controller: UIViewController) {
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .last { $0.isKeyWindow }
        window?.rootViewController = controller
    }
}
