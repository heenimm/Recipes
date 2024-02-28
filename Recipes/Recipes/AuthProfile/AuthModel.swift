// AuthModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель к экрану авторизации
struct AuthModel {
    /// Текст логина
    var login: String
    /// Текст пароля
    var password: String
    /// Статус показа клавиатуры
    var keyboardIsShown = false
    /// Высота клавиатуры
    var keyboardHeight: CGFloat = 0.0
    /// Правильный логин
    var validEmail = "Adm"
    /// Правильный пароль
    var validPassword = "123"
}
