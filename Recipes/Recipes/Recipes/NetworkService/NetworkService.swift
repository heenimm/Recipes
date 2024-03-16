// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол нетворк сериса
protocol NetworkServiceProtocol {
    /// Получение рецепта
    func getRecipe(completion: @escaping (Result<[Recipe], Error>) -> Void)
}

/// Сервис для работы с сетью
final class NetworkService: NetworkServiceProtocol {
    private var requestBuilder = RequestBuilder()

    func getRecipe(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let request = requestBuilder.getRecipesURL() else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(ResponseDTO.self, from: data)
                let recipes = result.hits.map { Recipe(dto: $0.recipe) }
                completion(.success(recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
