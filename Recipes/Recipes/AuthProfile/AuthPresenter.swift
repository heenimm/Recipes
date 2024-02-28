// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для view экрана авторизации
protocol AuthViewProtocol {
    /// Подъем вью наверх
    func upView(_ keyboardHeight: CGFloat)
    /// Опускание вью вниз
    func downView(_ keyboardHeight: CGFloat)
    /// Изменение строк связанных с полем почты
    func changeEmailLabels(_ color: UIColor, isIncorrectEmailHidden: Bool)
    /// Изменение строк связанных с полем паролем
    func changePasswordLabels(_ color: UIColor, isIncorrectPasswordHidden: Bool)
}

/// Протокол для презентера view экрана авторизации
protocol AuthViewPresenterProtocol {
    /// Обработка при поднятии клавиатуры
    func showKeyboardIfNeeded(_ notification: Notification)
    /// Обработка при опускании клавиатуры
    func downKeyboardIfNeeded(_ notification: Notification)
    /// Проверка почты
    func checkEmail(_ textField: UITextField)
    /// Проверка логина
    func checkAuthorisation(_ passwordText: String?)
}

/// Презентер окна авторизации
final class AuthPresenter: AuthViewPresenterProtocol {
    // MARK: - Constants

    enum Constants {
        static let emptyText = ""
    }

    // MARK: - Public Properties

    weak var authCoordinator: AuthCoordinator?

    // MARK: - Private Properties

    private var auth = Auth(login: Constants.emptyText, password: Constants.emptyText)
    private var view: AuthViewProtocol?

    // MARK: - Initializers

    init(view: AuthViewProtocol) {
        self.view = view
    }

    // MARK: - Public Methods

    func showKeyboardIfNeeded(_ notification: Notification) {
        if auth.keyboardIsShown { return }
        let userInfo = notification.userInfo
        if let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            auth.keyboardHeight = keyboardSize.height
            view?.upView(auth.keyboardHeight)
            auth.keyboardIsShown = true
        }
    }

    func downKeyboardIfNeeded(_ notification: Notification) {
        if !auth.keyboardIsShown { return }
        let userInfo = notification.userInfo
        if let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            auth.keyboardHeight = keyboardSize.height
            view?.downView(auth.keyboardHeight)
            auth.keyboardIsShown = false
        }
    }

    func checkEmail(_ textField: UITextField) {
        if textField.tag == 0 {
            let isValidEmail = isValidEmail(textField.text ?? Constants.emptyText)
            view?.changeEmailLabels(isValidEmail ? .appLabels : .red, isIncorrectEmailHidden: isValidEmail)
        }
    }

    func checkAuthorisation(_ passwordText: String?) {
        let isValidPassword = isValidPassword(passwordText ?? Constants.emptyText)
        view?.changePasswordLabels(isValidPassword ? .appLabels : .red, isIncorrectPasswordHidden: isValidPassword)
    }

    // MARK: - Private Methods

    private func isValidEmail(_ email: String) -> Bool {
        email == auth.validEmail
    }

    private func isValidPassword(_ password: String) -> Bool {
        password == auth.validPassword
    }
}
