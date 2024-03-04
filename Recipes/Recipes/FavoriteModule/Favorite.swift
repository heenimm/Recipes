// Favorite.swift
// Copyright © RoadMap. All rights reserved.

struct Favorite {
    /// Описание блюда
    let foodDescription: String
    /// Картинка блюда
    let foodImage: String
    /// Время приготовления
    let cookingTime: String
    /// Каллорийность
    let caloriesСontent: String

    static var favorites: [Favorite] = [
        Favorite(
            foodDescription: "Chilli and Tomato Fish",
            foodImage: "ragu",
            cookingTime: "60 min",
            caloriesСontent: "174 kkal"
        ),
        Favorite(
            foodDescription: "Salmon with Cantaloupe and Fried Shallots",
            foodImage: "burrito",
            cookingTime: "80 min",
            caloriesСontent: "410 kkal"
        ),
        Favorite(
            foodDescription: "Baked Fish with Lemon Herb Sauce",
            foodImage: "corn",
            cookingTime: "90 min",
            caloriesСontent: "616 kkal"
        )
    ]
}
