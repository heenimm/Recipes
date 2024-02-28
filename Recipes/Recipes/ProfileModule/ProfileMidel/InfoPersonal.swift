// InfoPersonal.swift
// Copyright © RoadMap. All rights reserved.

///Отражаем логику персональных данных
struct InfoPersonal {
    let userPhoto: String
    let userName: String
}

struct StorageInfoPersonal {
    let infoPersonals: [InfoPersonal] = [
        InfoPersonal(userPhoto: "userImage", userName: "Surname Name")
    ]
}
