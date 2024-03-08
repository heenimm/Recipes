// AuthCaretaker.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AuthCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "records"
    func save(records: [Auth]) {
        do {
            let data = try encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func retrieveRecords() -> [Auth] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([Auth].self, from: data)
        } catch { print(error)
            return []
        }
    }
}
