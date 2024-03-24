// DetailDishModel+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

public extension DetailDishModel {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DetailDishModel> {
        NSFetchRequest<DetailDishModel>(entityName: "DetailDishModel")
    }

    @NSManaged var image: String?
}

extension DetailDishModel: Identifiable {}
