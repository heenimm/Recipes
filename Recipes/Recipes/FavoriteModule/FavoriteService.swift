// FavoriteService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class FavoritesService {
    static let shared = FavoritesService()

    private var favorites: [Favorite] = Favorite.favorites

    private init() {}

    func add(_ item: Favorite) {
        favorites.append(item)
    }

    func remove(_ item: Favorite) {
        if let index = favorites.firstIndex(where: { $0.foodDescription == item.foodDescription }) {
            favorites.remove(at: index)
        }
    }

    func getAllFavorites() -> [Favorite] {
        favorites
    }
}
