// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AuthView {
//    func keyboardWillShow(_ notification: Notification)
    func upView(_ keyboardHeight: CGFloat)
    func downView(_ keyboardHeight: CGFloat)
}

protocol AuthViewPresenter {
//    init(view: GreetingView, person: Person)
//    func checkStatusKeyboard()
    func upKeyboard(_ notification: Notification)
    func downKeyboard(_ notification: Notification)
}

/// Презентер окна авторизации
final class AuthPresenter: AuthViewPresenter {
    weak var authCoordinator: AuthCoordinator?
    
    var authModel = AuthModel(login: "", password: "")
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
}
