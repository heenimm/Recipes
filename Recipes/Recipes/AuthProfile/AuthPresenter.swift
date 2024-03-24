// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Keychain
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
    func checkAuthorisation(_ passwordText: String?, _ loginText: String?)
}

/// Презентер окна авторизации
final class AuthPresenter: AuthViewPresenterProtocol {
    // MARK: - Constants

    enum Constants {
        static let emptyText = ""
        static let loginText = "login"
        static let passwordText = "password"
    }

    // MARK: - Public Properties

    weak var authCoordinator: AuthCoordinator?

    // MARK: - Private Properties

    private var auth = Auth(login: Constants.emptyText, password: Constants.emptyText)
    private var view: AuthViewProtocol?
    private var records: [Auth] = []
    private let authCaretaker = AuthCaretaker()

    // MARK: - Initializers

    init(view: AuthViewProtocol) {
        self.view = view
        auth.validEmail = Keychain.load(Constants.loginText) ?? Constants.emptyText
        auth.validPassword = Keychain.load(Constants.passwordText) ?? Constants.emptyText
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

    func checkAuthorisation(_ passwordText: String?, _ loginText: String?) {
        auth.login = loginText ?? Constants.emptyText
        auth.password = passwordText ?? Constants.emptyText
        if auth.validEmail == Constants.emptyText || auth.validPassword == Constants.emptyText {
            auth.validEmail = auth.login
            auth.validPassword = auth.password
            Keychain.save(auth.login, forKey: Constants.loginText)
            Keychain.save(auth.password, forKey: Constants.passwordText)
        }

        let isValidPassword = isValidPassword(passwordText ?? Constants.emptyText)
        view?.changePasswordLabels(isValidPassword ? .appLabels : .red, isIncorrectPasswordHidden: isValidPassword)
        if isValidPassword {
            authCoordinator?.onFinishFlow?()
        }
    }

    // MARK: - Private Methods

    private func isValidEmail(_ email: String) -> Bool {
        if auth.validEmail == Constants.emptyText {
            auth.validEmail = email
            Keychain.save(auth.login, forKey: Constants.loginText)
            Keychain.save(auth.password, forKey: Constants.passwordText)
        }
        return email == Keychain.load(Constants.loginText)
    }

    private func isValidPassword(_ password: String) -> Bool {
        password == Keychain.load(Constants.passwordText)
    }
}
