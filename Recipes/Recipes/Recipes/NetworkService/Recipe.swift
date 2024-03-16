// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные с рецептом
final class Recipe {
    // MARK: - Public Properties

    /// Описание блюда
    let foodDescription: String
    /// Картинка блюда
    let foodImage: String
    /// Время приготовления
    let cookingTime: Int
    /// Каллорийность
    let caloriesСontent: Int

    init(dto: RecipeDTO) {
        foodImage = dto.image
        foodDescription = dto.label
        cookingTime = Int(dto.totalTime)
        caloriesСontent = Int(dto.calories)
    }
}
