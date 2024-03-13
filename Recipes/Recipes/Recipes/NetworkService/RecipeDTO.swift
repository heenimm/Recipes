// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Рецепт
struct RecipeDTO: Codable {
    /// Картинка
    let image: String
    /// Название
    let label: String
    /// Время приготовления
    let totalTime: Double
    /// Калории
    let calories: Double
    /// URL
    let url: String
}
