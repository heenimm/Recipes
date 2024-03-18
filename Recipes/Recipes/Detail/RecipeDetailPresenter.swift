// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Состояние данных - общий для всех моделей благодаря дженерику говорит view как отрисоваться
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
    var dishDetail: [Recipe] = []
    var state: ViewState<Recipe> = .loading {
        /// наблюдатель, срабатывает когда изменили значение переменной, то есть каждый раз когда меняем состояние
        /// перезагружаем нашу таблицу новыми данными
        didSet {
            view?.updateState()
        }
    }

    private func updateDishDetail(searchPredicate: String? = nil) {
        state = .loading
        networkService.getDishDetail { result in
            switch result {
            case let .success(dishDetail):
                print(dishDetail)
            case let .failure(error):
                print(error)
            }
        }
    }

//    weak var coordinator: FavoriteCoordinator?

    // MARK: - Init

    init(view: RecipeDetailViewController? = nil) {
        self.view = view
    }
}
