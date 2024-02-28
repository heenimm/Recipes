// InfoBenefit.swift
// Copyright © RoadMap. All rights reserved.

///Отражаем логику ячейки бонусов
struct InfoBenefit {
    let menuImage: String
    let menuTitle: String
}

struct StorageInfoBenefit {
    let infoBenefits: [InfoBenefit] = [
        InfoBenefit(menuImage: "star.fill", menuTitle: "Bonuses"),
        InfoBenefit(menuImage: "doc.text.fill", menuTitle: "Terms & Privacy Policy"),
        InfoBenefit(menuImage: "rectangle.portrait.and.arrow.forward.fill", menuTitle: "Log out")
    ]
}
