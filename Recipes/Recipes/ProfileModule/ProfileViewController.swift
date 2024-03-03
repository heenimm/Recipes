// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Просмотр профиля пользователя
final class ProfileViewController: UIViewController {
    private enum Constants {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let plusBackgroundColor = "plusBackground"
        static let titleText = "Profile"
        static let changeNameAlert = "Change your name and surname"
        static let emptyText = ""
        static let nameSurnameText = "Surname Name"
        static let okText = "Ok"
        static let cancelText = "Cancel"
    }

    /// Тип ячеек
    private enum TypeCell {
        /// ячейка данных
        case infoPersonal
        /// ячейки дополнительной информации
        case infoBenefit
    }

    // MARK: - Public Properties

    var presenter: ProfilePresenter?

    // MARK: - Private Properties

    private let contentTypes: [TypeCell] = [.infoPersonal, .infoBenefit]
    private let storageInfoBenefit = InfoBenefit.getAllBenefits()
    private var storageInfoPersonal = InfoPersonal.getInfoPersonals()

    // MARK: - Visual Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PersonalInfoCell.self, forCellReuseIdentifier: PersonalInfoCell.reuseID)
        tableView.register(BenefitsInfoCell.self, forCellReuseIdentifier: BenefitsInfoCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.headerView(forSection: 0)
        return tableView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupNavigationItem()
    }

    // MARK: - Private Methods

    private func setupNavigationItem() {
        let label = UILabel()
        label.text = Constants.titleText
        label.sizeToFit()
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 28)
        let leftItem = UIBarButtonItem(customView: label)
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    private func setupSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func termsBottom() {
        let termsViewController = TermsUseViewController()
        if let termsUseSheet = termsViewController.sheetPresentationController {
            termsUseSheet.detents = [.medium(), .large()]
            termsUseSheet.prefersScrollingExpandsWhenScrolledToEdge = false
            termsUseSheet.prefersGrabberVisible = true
            termsUseSheet.largestUndimmedDetentIdentifier = .medium
            termsUseSheet.prefersEdgeAttachedInCompactHeight = true
            termsUseSheet.preferredCornerRadius = 30
        }
        present(termsViewController, animated: true)
    }

    func bonusesBottom() {
        let bonusesViewController = BonusesViewController()
        if let bonusUseSheet = bonusesViewController.sheetPresentationController {
            bonusUseSheet.detents = [.medium(), .large()]
            bonusUseSheet.prefersScrollingExpandsWhenScrolledToEdge = false
            bonusUseSheet.prefersGrabberVisible = true
            bonusUseSheet.largestUndimmedDetentIdentifier = .medium
            bonusUseSheet.prefersEdgeAttachedInCompactHeight = true
            bonusUseSheet.preferredCornerRadius = 30
        }
        present(bonusesViewController, animated: true)
    }

    private func addChangeNameAlert() -> UIAlertController {
        let alertController = UIAlertController(
            title: Constants.changeNameAlert,
            message: Constants.emptyText,
            preferredStyle: .alert
        )
        alertController.addTextField { textField in
            textField.placeholder = Constants.nameSurnameText
        }
        let actionOK = UIAlertAction(title: Constants.okText, style: .default) { [weak self] okAction in
            if let userName = alertController.textFields?.first?.text {
                self?.storageInfoPersonal[0].userName = userName
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        let actionCancel = UIAlertAction(title: Constants.cancelText, style: .cancel)
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        return alertController
    }
}

// MARK: - Extension ProfileViewController + UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch contentTypes[indexPath.section] {
        case .infoPersonal:
            return 270
        case .infoBenefit:
            return 53
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            presenter?.didSelectCell(at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extension ProfileViewController + UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        contentTypes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch contentTypes[section] {
        case .infoPersonal:
            return storageInfoPersonal.count
        case .infoBenefit:
            return storageInfoBenefit.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch contentTypes[indexPath.section] {
        case .infoPersonal:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PersonalInfoCell.reuseID,
                for: indexPath
            ) as? PersonalInfoCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.configure(storageInfoPersonal[indexPath.row])
            return cell
        case .infoBenefit:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BenefitsInfoCell.reuseID,
                for: indexPath
            ) as? BenefitsInfoCell else { return UITableViewCell() }
            cell.accessoryType = .disclosureIndicator
            cell.configure(storageInfoBenefit[indexPath.row])
            return cell
        }
    }
}

// MARK: - Extension ProfileViewController + PersonalInfoCellDelegate

extension ProfileViewController: PersonalInfoCellDelegate {
    func didTapChangePersonalInfoButton() {
        present(addChangeNameAlert(), animated: true)
    }
}
