// ResponseDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура ответа на запрос о рецепте
struct ResponseDTO: Codable {
    /// Массив рецептов
    let hits: [HitDTO]
}
