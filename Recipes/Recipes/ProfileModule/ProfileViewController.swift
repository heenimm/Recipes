// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Тип ячеек
private enum TypeCell {
    case infoPersonal // ячейка данных
    case infoBenefit // ячейки дополнительной информации
}

/// Просмотр профиля пользователя
final class ProfileViewController: UIViewController {
    
    private enum Constants {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let plusBackgroundColor = "plusBackground"
    }
    
    // MARK: - Public Properties

    var presenter: ProfilePresenter?

    // MARK: - Private Properties

    private let contentType: [TypeCell] = [.infoPersonal, .infoBenefit]
    private let storageInfoBenefit = StorageInfoBenefit()
    private var storageInfoPersonal = StorageInfoPersonal()

    // MARK: - Visual Components

    private lazy var headerLabel: UILabel = {
        let label = UILabel(frame: CGRect(
            x: view.frame.width,
            y: 0,
            width: view.frame.width,
            height: 50
        ))
        label.text = "   Profile"
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 28)
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PersonalInfoCell.self, forCellReuseIdentifier: PersonalInfoCell.reuseID)
        tableView.register(BenefitsInfoCell.self, forCellReuseIdentifier: BenefitsInfoCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.headerView(forSection: 0)
        tableView.tableHeaderView = headerLabel
        return tableView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods

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
        let termsVC = TermsUseViewController()
        if let termsUseSheet = termsVC.sheetPresentationController {
            termsUseSheet.detents = [.medium(), .large()]
            termsUseSheet.prefersScrollingExpandsWhenScrolledToEdge = false
            termsUseSheet.prefersGrabberVisible = true
            termsUseSheet.largestUndimmedDetentIdentifier = .medium
            termsUseSheet.prefersEdgeAttachedInCompactHeight = true
            termsUseSheet.preferredCornerRadius = 30
        }
        present(termsVC, animated: true)
    }

    func bonusesBottom() {
        let bonusesVC = BonusesViewController()
        if let bonusUseSheet = bonusesVC.sheetPresentationController {
            bonusUseSheet.detents = [.medium(), .large()]
            bonusUseSheet.prefersScrollingExpandsWhenScrolledToEdge = false
            bonusUseSheet.prefersGrabberVisible = true
            bonusUseSheet.largestUndimmedDetentIdentifier = .medium
            bonusUseSheet.prefersEdgeAttachedInCompactHeight = true
            bonusUseSheet.preferredCornerRadius = 30
        }
        present(bonusesVC, animated: true)
    }

    private func addChangeNameAlert() -> UIAlertController {
        let alertController = UIAlertController(
            title: "Change your name and surname",
            message: "",
            preferredStyle: .alert
        )
        alertController.addTextField { textField in
            textField.placeholder = "Name Surname"
        }
        let actionOK = UIAlertAction(title: "Ok", style: .default) { [weak self] okAction in
            if let userName = alertController.textFields?.first?.text {
                self?.storageInfoPersonal.infoPersonals[0].userName = userName
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        return alertController
    }
}

// MARK: - Extension ProfileViewController + UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch contentType[indexPath.section] {
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
        contentType.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch contentType[section] {
        case .infoPersonal:
            return storageInfoPersonal.infoPersonals.count
        case .infoBenefit:
            return storageInfoBenefit.infoBenefits.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch contentType[indexPath.section] {
        case .infoPersonal:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PersonalInfoCell.reuseID,
                for: indexPath
            ) as? PersonalInfoCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.configure(storageInfoPersonal.infoPersonals[indexPath.row])
            return cell
        case .infoBenefit:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BenefitsInfoCell.reuseID,
                for: indexPath
            ) as? BenefitsInfoCell else { return UITableViewCell() }
            cell.accessoryType = .disclosureIndicator
            cell.configure(storageInfoBenefit.infoBenefits[indexPath.row])
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
