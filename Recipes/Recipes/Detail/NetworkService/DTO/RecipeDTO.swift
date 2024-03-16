// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

struct RecipeDTO: Codable {
    let image: String
    let label: String
    let totalTime: Double
    let calories: Double
    let url: String
}
