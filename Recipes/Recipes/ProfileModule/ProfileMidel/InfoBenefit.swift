// InfoBenefit.swift
// Copyright © RoadMap. All rights reserved.

/// Отражаем логику ячейки бонусов
struct InfoBenefit {
    /// Название картинки бонусов
    let menuImage: String
    /// Заголовок бонусов
    let menuTitle: String

    /// Хранилище бонусов
    static func getAllBenefits() -> [InfoBenefit] {
        [
            InfoBenefit(menuImage: "star.fill", menuTitle: "Bonuses"),
            InfoBenefit(menuImage: "doc.text.fill", menuTitle: "Terms & Privacy Policy"),
            InfoBenefit(menuImage: "rectangle.portrait.and.arrow.forward.fill", menuTitle: "Log out")
        ]
    }
}
