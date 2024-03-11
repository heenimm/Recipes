// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Просмотр профиля пользователя
final class ProfileViewController: UIViewController {
    /// Тип ячеек
    private enum TypeCell {
        /// ячейка данных
        case infoPersonal
        /// ячейки дополнительной информации
        case infoBenefit
    }

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
        static let userImage = "userImage"
        static let username = "Surname Name"
    }

    // MARK: - Public Properties

    var presenter: ProfilePresenter?

    // MARK: - Private Properties

    private let infoPersonalCaretaker = InfoPersonalCaretaker()
    private var records: [InfoPersonal] = []
    private var infoPersonal = InfoPersonal(userPhoto: "userImage", userName: "Surname Name")

    private let contentTypes: [TypeCell] = [.infoPersonal, .infoBenefit]
    private let storageInfoBenefit = InfoBenefit.getAllBenefits()
    private var storageInfoPersonal = InfoPersonal.getInfoPersonals()

    private var termsViewController: TermsUseViewController!
    private var visualEffectView: UIVisualEffectView!
    private let termHeight: CGFloat = 700
    private let termHandleAreaHeight: CGFloat = 0
    private var termVisible = false
    private var nextState: TermState {
        termVisible ? .collapsed : .expanded
    }

    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0

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
        loadData()
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
        setupTerm()
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
                self?.presenter?.saveUsername(userName)
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

    private func loadData() {
        infoPersonal = infoPersonalCaretaker.retrievePersonalData().first ?? InfoPersonal(
            userPhoto: Constants.userImage,
            userName: Constants.username
        )
        records = [infoPersonal]
        storageInfoPersonal = records
    }
}

// MARK: - Extension ProfileViewController + UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch contentTypes[indexPath.section] {
        case .infoPersonal:
            return 270
        case .infoBenefit:
            return 60
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.row == 0 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        }
    }
}

// MARK: - Extension ProfileViewController

/// Добавления экрана политики через property animator
extension ProfileViewController {
    /// Состояния экрана
    enum TermState {
        /// Раскрыт
        case expanded
        /// Закрыт
        case collapsed
    }

    private func setupTerm() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)

        termsViewController = TermsUseViewController()
        addChild(termsViewController)
        view.addSubview(termsViewController.view)

        termsViewController.view.frame = CGRect(
            x: 0,
            y: view.frame.height - termHandleAreaHeight,
            width: view.bounds.width,
            height: termHeight
        )

        termsViewController.view.clipsToBounds = true

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ProfileViewController.handleTermTap(recognzier:))
        )
        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(ProfileViewController.handleTermPan(recognizer:))
        )

        termsViewController.view.addGestureRecognizer(tapGestureRecognizer)
        termsViewController.view.addGestureRecognizer(panGestureRecognizer)
        tabBarController?.tabBar.backgroundColor = .white
        animateTransitionIfNeeded(state: nextState, duration: 1.5)
    }

    @objc private func handleTermTap(recognzier: UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 1.5)
        default:
            break
        }
    }

    @objc private func handleTermPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 1.5)
        case .changed:
            let translation = recognizer.translation(in: termsViewController.view)
            var fractionComplete = translation.y / termHeight
            fractionComplete = termVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }

    private func animateTransitionIfNeeded(state: TermState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.termsViewController.view.frame.origin.y = self.view.frame.height - self.termHeight
                case .collapsed:
                    self.termsViewController.view.frame.origin.y = self.view.frame.height - self.termHandleAreaHeight
                    self.visualEffectView.removeFromSuperview()
                }
            }

            frameAnimator.addCompletion { _ in
                self.termVisible = !self.termVisible
                self.runningAnimations.removeAll()
            }

            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)

            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.termsViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.termsViewController.view.layer.cornerRadius = 0
                }
            }

            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)

            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }

            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }

    private func startInteractiveTransition(state: TermState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }

    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }

    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
