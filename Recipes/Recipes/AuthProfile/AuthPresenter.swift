// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для view экрана авторизации
protocol AuthView {
    /// Подъем вью наверх
    /// - Parameter keyboardHeight: высота клавиатуры
    func upView(_ keyboardHeight: CGFloat)
    /// Опускание вью вниз
    /// - Parameter keyboardHeight: высота клавиатуры
    func downView(_ keyboardHeight: CGFloat)
    /// Изменение строк связанных с полем почты
    /// - Parameters:
    ///   - color: цвет полей
    ///   - isIncorrectEmailHidden: Неправильность почты
    func changeEmailLabels(_ color: UIColor, isIncorrectEmailHidden: Bool)
    /// Изменение строк связанных с полем паролем
    /// - Parameters:
    ///   - color: цвет полей
    ///   - isIncorrectPasswordHidden: Неправильность пароля
    func changePasswordLabels(_ color: UIColor, isIncorrectPasswordHidden: Bool)
}

/// Протокол для презентера view экрана авторизации
protocol AuthViewPresenter {
    /// Обработка при поднятии клавиатуры
    /// - Parameter notification: уведомление о поднятии
    func showKeyboardIfNeeded(_ notification: Notification)
    /// Обработка при опускании клавиатуры
    /// - Parameter notification: уведомление о опускании
    func downKeyboardIfNeeded(_ notification: Notification)
    /// Проверка почты
    /// - Parameter textField: текстовое поле
    func checkEmail(_ textField: UITextField)
    /// Проверка логина
    /// - Parameter passwordText: текст пароля
    func checkAuthorisation(_ passwordText: String?)
}

/// Презентер окна авторизации
final class AuthPresenter: AuthViewPresenter {
    // MARK: - Constants

    enum Constants {
        static let emptyText = ""
    }

    // MARK: - Public Properties

    weak var authCoordinator: AuthCoordinator?

    // MARK: - Private Properties

    private var authModel = AuthModel(login: Constants.emptyText, password: Constants.emptyText)
    private var view: AuthView?

    // MARK: - Initializers

    init(view: AuthView) {
        self.view = view
    }

    // MARK: - Public Methods

    func showKeyboardIfNeeded(_ notification: Notification) {
        if authModel.keyboardIsShown { return }
        let userInfo = notification.userInfo
        if let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            authModel.keyboardHeight = keyboardSize.height
            view?.upView(authModel.keyboardHeight)
            authModel.keyboardIsShown = true
        }
    }

    func downKeyboardIfNeeded(_ notification: Notification) {
        if !authModel.keyboardIsShown { return }
        let userInfo = notification.userInfo
        if let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            authModel.keyboardHeight = keyboardSize.height
            view?.downView(authModel.keyboardHeight)
            authModel.keyboardIsShown = false
        }
    }

    func checkEmail(_ textField: UITextField) {
        if textField.tag == 0 {
            let isValidEmail = isValidEmail(textField.text ?? Constants.emptyText)
            if isValidEmail {
                view?.changeEmailLabels(.appLabels, isIncorrectEmailHidden: true)
            } else {
                view?.changeEmailLabels(.red, isIncorrectEmailHidden: false)
            }
        }
    }

    func checkAuthorisation(_ passwordText: String?) {
        let isValidPassword = isValidPassword(passwordText ?? Constants.emptyText)
        if isValidPassword {
            view?.changePasswordLabels(.appLabels, isIncorrectPasswordHidden: true)
        } else {
            view?.changePasswordLabels(.red, isIncorrectPasswordHidden: false)
        }
    }

    // MARK: - Private Methods

    private func isValidEmail(_ email: String) -> Bool {
        if email == authModel.validEmail { return true }
        return false
    }

    private func isValidPassword(_ password: String) -> Bool {
        if password == authModel.validPassword { return true }
        return false
    }
}
