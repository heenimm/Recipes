// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Состояние данных
enum ViewState<Model> {
    /// Загрузка
    case loading
    /// Есть данные
    case data(_ model: Model)
    /// Нет данных
    case noData
    /// Ошибка
    case error(_ error: Error)
}

/// Интерфейс взаимодействия с RecipeDetailPresenter
protocol RecipeDetailPresenterProtocol {
    /// Cостояние загрузки
    var state: ViewState<[Dish]> { get }
}

final class RecipeDetailPresenter {
    // MARK: - Private Properties

    private weak var view: RecipeDetailViewController?
    private var networkService = NetworkService()
    var dishDetail: [DishDetail] = []
    var state: ViewState<DishDetail> = .loading {
        didSet {
            view?.updateState()
        }
    }
    
    private func updateDishDetail(searchPredicate: String? = nil) {
        state = .loading
    }

//    weak var coordinator: FavoriteCoordinator?

    // MARK: - Init

    init(view: RecipeDetailViewController? = nil) {
        self.view = view
    }
}
