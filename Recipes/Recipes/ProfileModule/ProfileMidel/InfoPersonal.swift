// InfoPersonal.swift
// Copyright © RoadMap. All rights reserved.

/// Отражаем логику персональных данных
struct InfoPersonal {
    /// Фото юзера
    var userPhoto: String
    /// Никнейм
    var userName: String
}

/// Информация о человеке
struct StorageInfoPersonal {
    var infoPersonals: [InfoPersonal] = [
        InfoPersonal(userPhoto: "userImage", userName: "Surname Name")
    ]
}
