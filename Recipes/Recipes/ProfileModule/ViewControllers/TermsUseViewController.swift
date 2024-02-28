// TermsUseViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

private enum Constants {
    static let fontVerdana = "Verdana"
    static let fontVerdanaBold = "Verdana-Bold"
    static let xmarkImage = "xmark"
    static let leftInset = UIScreen.main.bounds.width / 2 - 80
    static let termsTitleText = "Terms of Use"
    static let termsKeyText = "terms_use"
}

/// Экран информации о пользовательском соглашении
final class TermsUseViewController: UIViewController {
    // MARK: - Static Constant

    typealias VoidHandler = () -> Void
    static let reuseID = String(describing: PersonalInfoCell.self)

    // MARK: - Visual Components

    private let termsTextView: UITextView = {
        let termsTextView = UITextView()
        termsTextView.text = NSLocalizedString(Constants.termsKeyText, comment: "")
        termsTextView.font = UIFont(name: Constants.fontVerdana, size: 14)
        return termsTextView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.setImage(UIImage(systemName: Constants.xmarkImage), for: .normal)
        button.addTarget(nil, action: #selector(dismissBottom), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.termsTitleText
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 20)
        return label
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        setupSubviews()
        setupTitleLabelConstraints()
        setupCloseButtonConstraints()
        setupTermsUseTextLabelConstraints()
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(termsTextView)
    }

    private func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 169)

        ])
    }

    private func setupCloseButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 20
            ),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -15

            ),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func setupTermsUseTextLabelConstraints() {
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termsTextView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 65
            ),
            termsTextView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),
            termsTextView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            ),
            termsTextView.heightAnchor.constraint(equalToConstant: 625),
            titleLabel.widthAnchor.constraint(equalToConstant: 340)
        ])
    }

    @objc func dismissBottom() {
        dismiss(animated: true, completion: nil)
    }
}
