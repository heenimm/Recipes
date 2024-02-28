// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

private enum Constants {
    static let fontVerdana = "Verdana"
    static let fontVerdanaBold = "Verdana-Bold"
    static let plusBackgroundColor = "plusBackground"
}

/// Тип ячеек
private enum TypeCell {
    case infoPersonal // ячейка данных
    case infoBenefit // ячейки дополнительной информации
}

/// Просмотр профиля пользователя
final class ProfileViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: ProfilePresenter?

    // MARK: - Private Properties

    private let contentType: [TypeCell] = [.infoPersonal, .infoBenefit]
    private let storageInfoBenefit = StorageInfoBenefit()
    private let storageInfoPersonal = StorageInfoPersonal()

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

    func termsActionSheet() {
        let termsVC = TermsUseViewController()
        if let actionSheet = termsVC.sheetPresentationController {
            actionSheet.detents = [.medium(), .large()]
            actionSheet.prefersScrollingExpandsWhenScrolledToEdge = false
            actionSheet.prefersGrabberVisible = true
            actionSheet.largestUndimmedDetentIdentifier = .medium
            actionSheet.prefersEdgeAttachedInCompactHeight = true
            actionSheet.preferredCornerRadius = 30
        }
        present(termsVC, animated: true)
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
