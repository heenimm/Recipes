// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
final class DetailPresenter {
    private weak var view: DetailViewController?
    weak var detailCoordinator: DetailCoordinator?

    init(view: DetailViewController) {
        self.view = view
    }

    func filterContentForSearchText(_ searchText: String, dishes: [Dish]) -> [Dish] {
        dishes.filter { $0.foodDescription.localizedCaseInsensitiveContains(searchText)
        } // данный метод ищет подстроку в строке без учета регистра
    }
}
