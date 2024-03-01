// Dish.swift
// Copyright © RoadMap. All rights reserved.

/// Виды блюд
struct Dish {
    /// Описание блюда
    let foodDescription: String
    /// Картинка блюда
    let foodImage: String
    /// Время приготовления
    let cookingTime: String
    /// Каллорийность
    let caloriesСontent: String

    /// Возвращает список блюд
    static func allFoods() -> [Dish] {
        [
            Dish(
                foodDescription: "Chilli and Tomato Fish",
                foodImage: "ragu",
                cookingTime: "60 min",
                caloriesСontent: "174 kkal"
            ),
            Dish(
                foodDescription: "Salmon with Cantaloupe and Fried Shallots",
                foodImage: "burrito",
                cookingTime: "80 min",
                caloriesСontent: "410 kkal"
            ),
            Dish(
                foodDescription: "Baked Fish with Lemon Herb Sauce",
                foodImage: "corn",
                cookingTime: "90 min",
                caloriesСontent: "616 kkal"
            ),
            Dish(
                foodDescription: "Lemon and Chilli Fish Burrito",
                foodImage: "fish",
                cookingTime: "100 min",
                caloriesСontent: "94 kkal"
            ),
            Dish(
                foodDescription: "Fast Roast Fish & Show Peas Recipes",
                foodImage: "roast",
                cookingTime: "60 min",
                caloriesСontent: "226 kkal"
            ),
            Dish(
                foodDescription: "Simple Fish And Corn",
                foodImage: "salmon",
                cookingTime: "95 min",
                caloriesСontent: "316 kkal"
            ),
            Dish(
                foodDescription: "Baked Fish with Lemon Herb Sauce",
                foodImage: "ragu",
                cookingTime: "75 min",
                caloriesСontent: "188 kkal"
            )
        ]
    }
}
