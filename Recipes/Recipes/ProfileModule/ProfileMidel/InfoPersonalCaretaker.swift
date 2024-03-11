// InfoPersonalCaretaker.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class InfoPersonalCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "personalData"
    func save(records: [InfoPersonal]) {
        do {
            let data = try encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func retrievePersonalData() -> [InfoPersonal] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([InfoPersonal].self, from: data)
        } catch { print(error)
            return []
        }
    }
}
