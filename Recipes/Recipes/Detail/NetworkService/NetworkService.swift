// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol NetworkServiceProtocol {
    func getDishDetail(completion: @escaping (Result<[DishDetail], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private var state: ViewState<[Dish]> = .loading
    private var requestBuilder = RequestBuilder()

    func getDishDetail(completion: @escaping (Result<[DishDetail], Error>) -> Void) {
        guard let request = requestBuilder.getRecipesURL() else { return }
//        dataTask(with: url) { data, _ , error in
//            if let error = error {
//                handler(.failure(error))
//            } else  {
//                handler(.success(data ?? Data()))
//            }
//        }
    }
}
