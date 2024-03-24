// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecipeModel")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB url - ", description.url?.absoluteString)
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do { try context.save()
            } catch {
                let error = error
                fatalError(error.localizedDescription)
            }
        }
    }

    func createDishDetail() {}
}
