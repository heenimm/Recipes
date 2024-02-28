// InfoPersonal.swift
// Copyright © RoadMap. All rights reserved.

/// Отражаем логику персональных данных
struct InfoPersonal {
    var userPhoto: String
    var userName: String
}

struct StorageInfoPersonal {
    var infoPersonals: [InfoPersonal] = [
        InfoPersonal(userPhoto: "userImage", userName: "Surname Name")
    ]
}
