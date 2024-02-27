// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Окно авторизации в приложении
final class AuthViewController: UIViewController {
    enum Constants {
        static let authorisationTitle = "Login"
        static let emailTitle = "Email Address"
        static let passwordTitle = "Password"
        static let loginPlaceholder = "Enter Email Address"
        static let passwordPlaceholder = "Enter Password"
        static let loginButtonText = "Login"
        static let verdanaBold16 = UIFont(name: "Verdana-Bold", size: 16)
        static let verdanaBold26 = UIFont(name: "Verdana-Bold", size: 26)
        static let verdanaBold24 = UIFont(name: "Verdana-Bold", size: 24)
        static let verdanaBold28 = UIFont(name: "Verdana-Bold", size: 28)
        static let verdanaBold18 = UIFont(name: "Verdana-Bold", size: 18)
        static let verdana18 = UIFont(name: "Verdana", size: 18)
        static let verdana14 = UIFont(name: "Verdana", size: 14)
        static let verdana16 = UIFont(name: "Verdana", size: 16)
        static let logoCoffe = UIImage(named: "LogoCoffe")
        static let visiblePassword = UIImage(named: "visiblePassword")
        static let invisiblePassword = UIImage(named: "invisiblePassword")
    }
    private let passwordVisibleButton: UIButton = {
        let button = UIButton()
        button.alpha = 1
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Constants.verdanaBold16
        //        button.backgroundColor = .appButton
        //            button.addTarget(nil, action: #selector(passwordVisibleButtonTouched), for: .touchUpInside)
        return button
    }()
    private let authorisationLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.authorisationTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.verdanaBold28
        label.textColor = .appLabels
        return label
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.emailTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.verdanaBold18
        label.textColor = .appLabels
        return label
    }()
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.passwordTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.verdanaBold18
        label.textColor = .appLabels
        return label
    }()
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.loginPlaceholder
        textField.font = Constants.verdana18
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.textColor = .black
//        textField.addTarget(nil, action: #selector(textDidChange), for: .valueChanged)
        return textField
    }()
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.passwordPlaceholder
        textField.font = Constants.verdana18
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.textColor = .black
//        textField.addTarget(nil, action: #selector(textDidChange), for: .valueChanged)
        return textField
    }()
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 12
        loginButton.backgroundColor = .black
        loginButton.setTitle(Constants.loginButtonText, for: .normal)
        loginButton.titleLabel?.font = Constants.verdana16
        loginButton.backgroundColor = .appButton
        //        loginButton.addTarget(nil, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.isEnabled = true
        return loginButton
    }()
    var presenter: AuthPresenter?
    var keyboardIsShown = false
    var keyboardHeight: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    private func setLabels() {
        view.addSubview(authorisationLabel)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        NSLayoutConstraint.activate([
            authorisationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 202),
            authorisationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorisationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            authorisationLabel.heightAnchor.constraint(equalToConstant: 34),
            emailLabel.topAnchor.constraint(equalTo: authorisationLabel.bottomAnchor, constant: 23),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -170),
            emailLabel.heightAnchor.constraint(equalToConstant: 32),
            passwordLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 79),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -170),
            passwordLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    private func setTextFields() {
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 6),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 6),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func addGradientToView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    private func configureUI() {
        setLabels()
        setTextFields()
        addGradientToView()
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        self.presenter?.downKeyboard(notification)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        self.presenter?.upKeyboard(notification)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension AuthViewController: AuthView {
    func upView(_ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y -= keyboardHeight
        }
    }
    func downView(_ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y += keyboardHeight
        }
    }
}
