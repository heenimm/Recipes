// AnalyticsLogger.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол отвечающий за
protocol Command {
    func execute()
}

/// Класс для записи логов
final class AnalyticsLogger {
    static let shared = AnalyticsLogger()

    private var logFileName = "user_actions.txt"
    private var logFileURL: URL?
    private var actions: [String] = []

    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        logFileURL = documentsDirectory.appendingPathComponent(logFileName)
    }

    func logAction(_ action: String) {
        actions.append(action)
    }

    func saveLogToFile() {
        print(logFileURL?.path)
        guard let fileURL = logFileURL else { return }

        do {
            let logString = actions.joined(separator: "\n")
            try logString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("Лог аналитики успешно записан в файл.")
        } catch {
            print("Ошибка при записи лога аналитики в файл:", error.localizedDescription)
        }
    }
}

// Команда для записи лога действия пользователя
final class LogUserActionCommand: Command {
    private let action: String

    init(action: String) {
        self.action = action
    }

    func execute() {
        AnalyticsLogger.shared.logAction(action)
    }
}

// Класс для управления выполнением команд
final class Invoker {
    private var commands: [Command] = []

    func addCommand(_ command: Command) {
        commands.append(command)
    }

    func executeCommands() {
        for command in commands {
            command.execute()
        }
    }
}
