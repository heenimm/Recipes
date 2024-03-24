// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Рецепт
struct RecipeDTO: Codable {

    /// URL
    let url: String
    /// Идентификатор блюда
    let uri: String
    /// Изображение блюда
    let image: String
    /// Название
    let label: String
    /// калорийность
    let calories: Double
    /// время приготовления
    let totalTime: Int
    /// вес
    let totalWeight: Double
    // рецепт блюда
    let ingredientLines: [String]
    /// Количество жиров в блюде.
    let totalNutrients, totalDaily: [String: TotalDTO]
}
