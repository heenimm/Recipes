// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

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

    func filterContentForSearchText(_ searchText: String, dishes: [Dish]) -> [Dish] {
        dishes.filter { $0.foodDescription.localizedCaseInsensitiveContains(searchText)
        } // данный метод ищет подстроку в строке без учета регистра
    }

    func sortTableview(sender: SortingButton, dishes: [Dish], headerView: HeaderCell) -> [Dish] {
        switch sender.currentState {
        case .none:
            sender.currentState = .none
            return Dish.allFoods()
        case .ascending:
            if sender.titleLabel?
                .text ==
                Constants.caloriesText
            {
                headerView.timeStateButton.currentState = .none
                return dishes
                    .sorted {
                        Int($0.caloriesСontent.components(separatedBy: " ").first ?? "") ?? 0 <
                            Int($1.caloriesСontent.components(separatedBy: " ").first ?? "") ?? 0
                    }
            } else {
                headerView.caloriesStateButton.currentState = .none
                return dishes.sorted {
                    Int($0.cookingTime.components(separatedBy: " ").first ?? "") ?? 0 <
                        Int($1.cookingTime.components(separatedBy: " ").first ?? "") ?? 0
                }
            }
        case .descending:
            if sender.titleLabel?.text == Constants.caloriesText {
                headerView.timeStateButton.currentState = .none
                return dishes.sorted {
                    Int($0.caloriesСontent.components(separatedBy: " ").first ?? "") ?? 0 >
                        Int($1.caloriesСontent.components(separatedBy: " ").first ?? "") ?? 0
                }
            } else {
                headerView.caloriesStateButton.currentState = .none
                return dishes.sorted {
                    Int($0.cookingTime.components(separatedBy: " ").first ?? "") ?? 0 >
                        Int($1.cookingTime.components(separatedBy: " ").first ?? "") ?? 0
                }
            }
        }
    }
}
