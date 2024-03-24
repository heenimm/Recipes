// CoreDataManager.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import UIKit

public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    override private init() {}

    private var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }

    private var context: NSManagedObjectContext? {
        appDelegate?.persistentContainer.viewContext
    }

    public func createUserProfile(login: String, password: Int16) {
        guard let userProfileEntityDescription = NSEntityDescription.entity(forEntityName: "UserProfile", in: context!)
        else { return }
        let userProfile = UserProfile(entity: userProfileEntityDescription, insertInto: context)
        userProfile.login = login
        userProfile.password = password
    }

    public func fetchUserProfiles() -> [UserProfile] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
        do {
            return (try? context?.fetch(fetchRequest) as? [UserProfile]) ?? []
        }
    }

    public func fetchUserProfile(_ login: String) -> UserProfile? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
        do {
            let userProfiles = try? context?.fetch(fetchRequest) as? [UserProfile]
            return userProfiles?.first(where: { $0.login == login })
        }
    }

    public func updateUserProfile(with login: String, newPassword: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
        do {
            guard let userProfiles = try? context?.fetch(fetchRequest) as? [UserProfile],
                  let userProfile = userProfiles.first(where: { $0.login == login }) else { return }
            userProfile.password = newPassword
        }
        appDelegate?.saveContext()
    }

    public func deleteUserProfiles() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
        do {
            let userProfiles = try? context?.fetch(fetchRequest) as? [UserProfile]
            userProfiles?.forEach { context?.delete($0) }
        }
        appDelegate?.saveContext()
    }

    public func deleteUserProfile(_ login: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
        do {
            guard let userProfiles = try? context?.fetch(fetchRequest) as? [UserProfile],
                  let userProfile = userProfiles.first(where: { $0.login == login }) else { return }
        }
        appDelegate?.saveContext()
    }
}
