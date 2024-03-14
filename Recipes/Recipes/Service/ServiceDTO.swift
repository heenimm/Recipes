// ServiceDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

struct RecipeDTO: Codable {
    let uri: String
    let label: String
    let image: String
    let url: String
    let calories: Double
    let totalTime: Int
    let totalWeight: Double
    let ingredientLines: [String]
    let totalNutrients, totalDaily: [String: TotalDTO]
}

struct TotalDTO: Codable {
    
}
