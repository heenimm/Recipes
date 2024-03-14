// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояния экрана рецептов
enum State {
    /// Загрузка
    case loading
    /// Успешная загрузка
    case data
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

    // TODO: Тест сервиса, убрать
    var networkService: NetworkService!

    init(view: DetailViewController) {
        self.view = view

        // TODO: Тест сервиса, убрать
        networkService = NetworkService()
        networkService.getRecipe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(recipesCategory):
                print(recipesCategory)
            case let .failure(error):
                print(error)
            }
        }
    }

    func filterContentForSearchText(_ searchText: String, dishes: [Recipe]) -> [Recipe] {
        dishes.filter { $0.foodDescription.localizedCaseInsensitiveContains(searchText)
        } // данный метод ищет подстроку в строке без учета регистра
    }

    func changeState() {
        view?.setState(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.view?.setState(.data)
        }
    }

//    func sortTableview(sender: SortingButton, dishes: [Recipe], headerView: HeaderCell) -> [Recipe] {
//        switch sender.currentState {
//        case .none:
//            sender.currentState = .none
    ////            return Dish.allFoods()
//            return dishes
//        case .ascending:
//            if sender.titleLabel?
//                .text ==
//                Constants.caloriesText
//            {
//                headerView.timeStateButton.currentState = .none
//                return dishes
//                    .sorted {
//                        Int($0.caloriesСontent.components(separatedBy: " ").first ?? "") ?? 0 <
//                            Int($1.caloriesСontent.components(separatedBy: " ").first ?? "") ?? 0
//                    }
//            } else {
//                headerView.caloriesStateButton.currentState = .none
//                return dishes.sorted {
//                    Int($0.cookingTime.components(separatedBy: " ").first ?? "") ?? 0 <
//                        Int($1.cookingTime.components(separatedBy: " ").first ?? "") ?? 0
//                }
//            }
//        case .descending:
//            if sender.titleLabel?.text == Constants.caloriesText {
//                headerView.timeStateButton.currentState = .none
//                return dishes.sorted {
//                    Int($0.caloriesСontent.components(separatedBy: " ").first ?? "") ?? 0 >
//                        Int($1.caloriesСontent.components(separatedBy: " ").first ?? "") ?? 0
//                }
//            } else {
//                headerView.caloriesStateButton.currentState = .none
//                return dishes.sorted {
//                    Int($0.cookingTime.components(separatedBy: " ").first ?? "") ?? 0 >
//                        Int($1.cookingTime.components(separatedBy: " ").first ?? "") ?? 0
//                }
//            }
//        }
//    }
}
