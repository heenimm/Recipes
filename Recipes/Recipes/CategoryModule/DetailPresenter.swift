// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояния экрана рецептов
enum State<Model> {
    /// Загрузка
    case loading
    /// Успешная загрузка
    case data(Model)
    /// Нет данных
    case noData
    /// ошибка
    case error(_ error: Error)
}

/// отрабатывает логику сортировки и фильтрации
final class DetailPresenter {
    private enum Constants {
        static let caloriesText = "Calories"
    }

    private weak var view: DetailViewController?
    weak var detailCoordinator: RecipesCoordinator?

    init(view: DetailViewController) {
        self.view = view
    }

    func filterContentForSearchText(_ searchText: String, dishes: [Recipe]) -> [Recipe] {
        dishes.filter { $0.foodDescription.localizedCaseInsensitiveContains(searchText)
        } // данный метод ищет подстроку в строке без учета регистра
    }

    func changeState(dishes: [Recipe]) {
        view?.setState(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.view?.setState(.data(dishes))
        }
    }

    func sortTableview(sender: SortingButton, dishes: [Recipe], headerView: HeaderCell) -> [Recipe] {
        switch sender.currentState {
        case .none:
            sender.currentState = .none
            return dishes
        case .ascending:
            if sender.titleLabel?
                .text ==
                Constants.caloriesText
            {
                headerView.timeStateButton.currentState = .none
                return dishes
                    .sorted { $0.caloriesСontent <
                        $1.caloriesСontent
                    }
            } else {
                headerView.caloriesStateButton.currentState = .none
                return dishes.sorted { $0.cookingTime <
                    $1.cookingTime
                }
            }
        case .descending:
            if sender.titleLabel?.text == Constants.caloriesText {
                headerView.timeStateButton.currentState = .none
                return dishes.sorted {
                    $0.caloriesСontent >
                        $1.caloriesСontent
                }
            } else {
                headerView.caloriesStateButton.currentState = .none
                return dishes.sorted {
                    $0.cookingTime >
                        $1.cookingTime
                }
            }
        }
    }
}
