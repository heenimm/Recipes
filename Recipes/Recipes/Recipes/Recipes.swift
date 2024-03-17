// Recipes.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Типы рецептов
struct Recipes {
    /// Картинка типа
    let image: UIImage
    /// Название типа
    let name: String
    let dishType: DishType

    /// Метод возвращающий типы рецептов в коллекции
    static func allRecipes() -> [Recipes] {
        [
            Recipes(image: UIImage(named: "saladPic") ?? UIImage(), name: "Salad", dishType: .salad),
            Recipes(image: UIImage(named: "soupPic") ?? UIImage(), name: "Soup", dishType: .soup),
            Recipes(image: UIImage(named: "chickenPic") ?? UIImage(), name: "Chicken", dishType: .chicken),
            Recipes(image: UIImage(named: "meatPic") ?? UIImage(), name: "Meat", dishType: .meat),
            Recipes(image: UIImage(named: "fishPic") ?? UIImage(), name: "Fish", dishType: .fish),
            Recipes(image: UIImage(named: "sidePic") ?? UIImage(), name: "Side dish", dishType: .sideDish),
            Recipes(image: UIImage(named: "drinksPic") ?? UIImage(), name: "Drinks", dishType: .drinks),
            Recipes(image: UIImage(named: "pancakesPic") ?? UIImage(), name: "Pancakes", dishType: .pancake),
            Recipes(image: UIImage(named: "dessertsPic") ?? UIImage(), name: "Desserts", dishType: .desserts)
        ]
    }
}

/// Типы ячеек
enum TypeCells {
    /// Маленькая ячейка рецептов
    case small
    /// Средняя ячейка рецептов
    case medium
    /// Большая ячейка рецептов
    case big
}
