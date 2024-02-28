// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AuthView {
    func upView(_ keyboardHeight: CGFloat)
    func downView(_ keyboardHeight: CGFloat)
    func changeEmailColor(_ color: UIColor, isIncorrectEmailHidden: Bool)
    func changePasswordColor(_ color: UIColor, isIncorrectPasswordHidden: Bool)
}

protocol AuthViewPresenter {
    func upKeyboard(_ notification: Notification)
    func downKeyboard(_ notification: Notification)
    func checkEmail(_ textField: UITextField)
    func checkAuthorisation(_ passwordText: String?)
}

/// Презентер окна авторизации
final class AuthPresenter: AuthViewPresenter {
    // MARK: - Types

    // MARK: - Constants

    enum Constants {
        static let emptyText = ""
    }

    // MARK: - IBOutlets

    // MARK: - Visual Components

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    // MARK: - Public Methods

    // MARK: - IBAction

    // MARK: - Private Methods

    weak var authCoordinator: AuthCoordinator?
    private var authModel = AuthModel(login: Constants.emptyText, password: Constants.emptyText)
    var view: AuthView?
    init(view: AuthView) {
        self.view = view
    }

    func upKeyboard(_ notification: Notification) {
        if authModel.keyboardIsShown { return }
        let userInfo = notification.userInfo
        if let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            authModel.keyboardHeight = keyboardSize.height
            view?.upView(authModel.keyboardHeight)
            authModel.keyboardIsShown = true
        }
    }

    func downKeyboard(_ notification: Notification) {
        if !authModel.keyboardIsShown { return }
        let userInfo = notification.userInfo
        if let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            authModel.keyboardHeight = keyboardSize.height
            view?.downView(authModel.keyboardHeight)
            authModel.keyboardIsShown = false
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        if email == authModel.validEmail { return true }
        return false
    }

    func isValidPassword(_ password: String) -> Bool {
        if password == authModel.validPassword { return true }
        return false
    }

    func checkEmail(_ textField: UITextField) {
        if textField.tag == 0 {
            let isValidEmail = isValidEmail(textField.text ?? Constants.emptyText)
            if isValidEmail {
                view?.changeEmailColor(.appLabels, isIncorrectEmailHidden: true)
            } else {
                view?.changeEmailColor(.red, isIncorrectEmailHidden: false)
            }
        }
    }

    func checkAuthorisation(_ passwordText: String?) {
        let isValidPassword = isValidPassword(passwordText ?? Constants.emptyText)
        if isValidPassword {
            view?.changePasswordColor(.appLabels, isIncorrectPasswordHidden: true)
        } else {
            view?.changePasswordColor(.red, isIncorrectPasswordHidden: false)
        }
    }
}
