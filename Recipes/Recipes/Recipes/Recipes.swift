// Recipes.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Типы рецептов
struct Recipes {
    /// Картинка типа
    let image: UIImage
    /// Название типа
    let name: String

    /// Метод возвращающий типы рецептов в коллекции
    static func allRecipes() -> [Recipes] {
        [
            Recipes(image: UIImage(named: "saladPic") ?? UIImage(), name: "Salad"),
            Recipes(image: UIImage(named: "soupPic") ?? UIImage(), name: "Soup"),
            Recipes(image: UIImage(named: "chickenPic") ?? UIImage(), name: "Chicken"),
            Recipes(image: UIImage(named: "meatPic") ?? UIImage(), name: "Meat"),
            Recipes(image: UIImage(named: "fishPic") ?? UIImage(), name: "Fish"),
            Recipes(image: UIImage(named: "sidePic") ?? UIImage(), name: "Side dish"),
            Recipes(image: UIImage(named: "drinksPic") ?? UIImage(), name: "Drinks"),
            Recipes(image: UIImage(named: "pancakesPic") ?? UIImage(), name: "Pancakes"),
            Recipes(image: UIImage(named: "dessertsPic") ?? UIImage(), name: "Desserts")
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
