// RequestBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Типы блюд
enum DishType: String {
    /// Салат
    case salad
    /// Суп
    case soup
    /// Панкейк
    case pancake
    /// Напитки
    case drinks
    /// Десерты
    case desserts
    /// Курица
    case chicken
    /// Мясо
    case meat
    /// Рыба
    case fish
    /// Гарнир
    case sideDish

    var dishCategory: String {
        switch self {
        case .chicken, .meat, .fish, .sideDish:
            return "Main Course"
        case .salad:
            return "salad"
        case .soup:
            return "soup"
        case .pancake:
            return "pancake"
        case .drinks:
            return "drinks"
        case .desserts:
            return "desserts"
        }
    }
}

/// Построитель запроса
final class RequestBuilder {
    /// Получение URL запроса для рецептов
    func getRecipesURL(dishType: DishType) -> URLRequest? {
        let baseURL = "https://api.edamam.com/api/recipes/v2"

        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "app_id", value: "a3e12f60"),
            URLQueryItem(name: "app_key", value: "db85e54b3062b46720031aeba0470ed2"),
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "dishType", value: dishType.dishCategory)
        ]

        guard let url = components?.url else { return nil }
        return URLRequest(url: url)
    }

    /// Получение URL запроса для рецептов
    func getDetailDishURL() -> URLRequest? {
        let baseURL = "https://api.edamam.com/api/recipes/v2"

        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "app_id", value: "a3e12f60"),
            URLQueryItem(name: "app_key", value: "db85e54b3062b46720031aeba0470ed2"),
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(
                name: "dishType",
                value: "http://www.edamam.com%2Fontologies%2Fedamam.owl%23recipe_bcc4c0a5d8cc5dd551f00204b7e05e34"
            )
        ]

        guard let url = components?.url else { return nil }
        return URLRequest(url: url)
    }
}
