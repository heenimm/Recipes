// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Окно авторизации в приложении
final class AuthViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let authorisationTitle = "Login"
        static let emailTitle = "Email Address"
        static let incorrectLabelText = "Incorrect format"
        static let incorrectPasswordText = "You entered the wrong password"
        static let passwordTitle = "Password"
        static let loginPlaceholder = "Enter Email Address"
        static let passwordPlaceholder = "Enter Password"
        static let loginButtonText = "Login"
        static let errorImage = "errorAuthorisation"
        static let spinerText = "spiner"
        static let verdanaBold16 = UIFont(name: "Verdana-Bold", size: 16)
        static let verdanaBold26 = UIFont(name: "Verdana-Bold", size: 26)
        static let verdanaBold24 = UIFont(name: "Verdana-Bold", size: 24)
        static let verdanaBold28 = UIFont(name: "Verdana-Bold", size: 28)
        static let verdanaBold18 = UIFont(name: "Verdana-Bold", size: 18)
        static let verdanaBold12 = UIFont(name: "Verdana-Bold", size: 12)
        static let verdana18 = UIFont(name: "Verdana", size: 18)
        static let verdana14 = UIFont(name: "Verdana", size: 14)
        static let verdana16 = UIFont(name: "Verdana", size: 16)
    }

    // MARK: - Visual Components

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

    private let incorrectEmailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.incorrectLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.verdanaBold12
        label.textColor = .red
        label.isHidden = true
        return label
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.passwordTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.verdanaBold16
        label.textColor = .appLabels
        return label
    }()

    private let incorrectPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.incorrectPasswordText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.verdanaBold12
        label.textColor = .red
        label.isHidden = true
        return label
    }()

    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.loginPlaceholder
        textField.font = Constants.verdana18
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.textColor = .black
        textField.tag = 0
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.passwordPlaceholder
        textField.font = Constants.verdana18
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.textColor = .black
        textField.addTarget(nil, action: #selector(textDidChange), for: .editingChanged)
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
        loginButton.addTarget(nil, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.isEnabled = true
        return loginButton
    }()

    private let errorAuthorisationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.errorImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()

    // MARK: - Public Properties

    var presenter: AuthPresenter?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func addNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func addCesture() {
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
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.appButton.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 3)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func addButtons() {
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func addCheckingAuthorisationElements() {
        view.addSubview(incorrectEmailLabel)
        view.addSubview(incorrectPasswordLabel)
        view.addSubview(errorAuthorisationImageView)
        NSLayoutConstraint.activate([
            incorrectEmailLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            incorrectEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            incorrectEmailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 140),
            incorrectEmailLabel.heightAnchor.constraint(equalToConstant: 19),

            incorrectPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            incorrectPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            incorrectPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 140),
            incorrectPasswordLabel.heightAnchor.constraint(equalToConstant: 19),

            errorAuthorisationImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83),
            errorAuthorisationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorAuthorisationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorAuthorisationImageView.heightAnchor.constraint(equalToConstant: 87)
        ])
    }

    private func configureUI() {
        setLabels()
        setTextFields()
        addGradientToView()
        addButtons()
        addCheckingAuthorisationElements()
        addNotification()
        addCesture()
        loginTextField.delegate = self
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        presenter?.downKeyboardIfNeeded(notification)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        presenter?.showKeyboardIfNeeded(notification)
    }

    @objc private func loginButtonTapped() {
        loginButton.setTitle(Constants.spinerText, for: .normal)
        loginButton.isEnabled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loginButton.setTitle(Constants.loginButtonText, for: .normal)
            self.loginButton.isEnabled = true
            self.presenter?.checkAuthorisation(self.passwordTextField.text)
        }
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func textDidChange() {
        errorAuthorisationImageView.isHidden = true
        incorrectPasswordLabel.isHidden = true
        errorAuthorisationImageView.isHidden = true
        passwordLabel.textColor = .appLabels
        passwordTextField.layer.borderColor = UIColor.appLabels.cgColor
    }
}

/// Определение функций из протокола AuthView
extension AuthViewController: AuthView {
    func changePasswordLabels(_ color: UIColor, isIncorrectPasswordHidden: Bool) {
        passwordLabel.textColor = color
        passwordTextField.layer.borderColor = color.cgColor
        incorrectPasswordLabel.isHidden = isIncorrectPasswordHidden
        errorAuthorisationImageView.isHidden = isIncorrectPasswordHidden
    }

    func changeEmailLabels(_ color: UIColor, isIncorrectEmailHidden: Bool) {
        emailLabel.textColor = color
        loginTextField.layer.borderColor = color.cgColor
        incorrectEmailLabel.isHidden = isIncorrectEmailHidden
    }

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

/// Определение функций из UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter?.checkEmail(textField)
    }
}
