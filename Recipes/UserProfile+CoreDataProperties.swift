// UserProfile+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

public extension UserProfile {
    @nonobjc class func fetchRequest() -> NSFetchRequest<UserProfile> {
        NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }

    @NSManaged var login: String?
    @NSManaged var password: Int16
}

extension UserProfile: Identifiable {}
