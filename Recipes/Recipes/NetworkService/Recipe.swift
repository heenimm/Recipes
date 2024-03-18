// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные с рецептом
final class Recipe {
    // MARK: - Public Properties

    /// Идентификатор блюда
    let uri: String
    /// Описание блюда
    let foodDescription: String
    /// Картинка блюда
    let foodImage: String
    /// Время приготовления
    let cookingTime: Int
    /// Каллорийность
    let caloriesСontent: Int
    /// Вес
    let weight: Double
    // Pецепт блюда
    let ingredientLines: [String]
    /// Количество жиров в блюде.
    var fats: Double?
    /// Количество белков в блюде.
    let proteins: Double?
    /// Количество углеводов в блюде.
    let carbohydrates: Double?

    init(dto: RecipeDTO) {
        uri = dto.uri
        foodImage = dto.image
        foodDescription = dto.label
        cookingTime = Int(dto.totalTime)
        caloriesСontent = Int(dto.calories)
//        cookingTime = dto.totalTime
        weight = dto.totalWeight
        ingredientLines = dto.ingredientLines
        fats = dto.totalNutrients["ENERC_KCAL"]?.quantity
        carbohydrates = dto.totalNutrients["CHOCDF"]?.quantity
        fats = dto.totalNutrients["FAT"]?.quantity
        proteins = dto.totalNutrients["PROCNT"]?.quantity
    }
}
