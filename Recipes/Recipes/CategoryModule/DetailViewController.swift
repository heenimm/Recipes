// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью экрана с рецептами
final class DetailViewController: UIViewController {
    // MARK: - Enums

    private enum Constants {
        static let titleText = "  Fish"
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let back = "back"
    }

    // MARK: - Public Properties

    var networkService: NetworkService!
    var presenter: DetailPresenter?
    let invoker = Invoker()
    var dishType: DishType!
    var titleText: String?

    let switchToFishRecipesCommand =
        LogUserActionCommand(action: "Пользователь перешел на Экран со списком рецептов из Рыбы")

    // MARK: - Private Properties

//    private var dishes = Dish.allFoods()
    private var dishes: [Recipe] = []
    private var state: State? {
        didSet {
            detailTableView.reloadData()
        }
    }

    // MARK: - Visual Components

    private var detailTableView: UITableView!
    private lazy var headerView: HeaderCell = {
        let headerView = HeaderCell(frame: CGRect(
            origin: .zero,
            size: CGSize(width: 100, height: 100)
        ))
        headerView.caloriesStateButton.addTarget(self, action: #selector(tappedSortButton(_:)), for: .touchUpInside)
        headerView.timeStateButton.addTarget(self, action: #selector(tappedSortButton(_:)), for: .touchUpInside)
        return headerView
    }()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        initSortButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        invoker.addCommand(switchToFishRecipesCommand)
        invoker.executeCommands()
        AnalyticsLogger.shared.saveLogToFile()
        setupTableView()
        setupNavigationItem()
        changeState()
        updateRecipes()
    }

    // MARK: - Public Methods

    func setState(_ state: State) {
        self.state = state
    }

    func updateRecipes() {
        networkService = NetworkService()
        networkService.dishType = dishType
        networkService.getRecipe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(recipesCategory):
                dishes = recipesCategory
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - Private Methods

    private func changeState() {
        presenter?.changeState()
    }

    private func setupNavigationItem() {
        let button = UIButton(type: .system)
        button.setTitle(titleText, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.fontVerdanaBold, size: 28)
        button.setImage(
            UIImage(named: Constants.back)?.withTintColor(.black, renderingMode: .alwaysOriginal),
            for: .normal
        )
        button.sizeToFit()
        button.addTarget(self, action: #selector(backToRecipes), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }

    private func setupTableView() {
        detailTableView = UITableView()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.backgroundColor = .white
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        detailTableView.separatorStyle = .none
        detailTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.description())
        detailTableView.register(ShimmerTableViewCell.self, forCellReuseIdentifier: ShimmerTableViewCell.description())

        headerView.searchBar.delegate = self
        detailTableView.tableHeaderView = headerView

        view.addSubview(detailTableView)

        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func initSortButton() {}

    @objc private func backToRecipes() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func tappedSortButton(_ sender: SortingButton) {
        if let dishes = presenter?.sortTableview(sender: sender, dishes: dishes, headerView: headerView) {
            self.dishes = dishes
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
        print("нажата \(sender.currentState)")
    }
}

// MARK: - Extension DetailViewController + UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extension DetailViewController + UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            6
        case .data:
            dishes.count
        case .noData, .error:
            0
        default:
            6
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loading:
            guard let shimmerCell = detailTableView
                .dequeueReusableCell(
                    withIdentifier: ShimmerTableViewCell.description(),
                    for: indexPath
                ) as? ShimmerTableViewCell
            else { return UITableViewCell() }
            return shimmerCell
        case .data:
            guard let cell = detailTableView.dequeueReusableCell(
                withIdentifier: DetailTableViewCell.description(),
                for: indexPath
            ) as? DetailTableViewCell else { return UITableViewCell() }
            cell.configure(dish: dishes[indexPath.row])
            cell.delegate = self
            return cell
        case .noData, .error:
            return UITableViewCell()
        default:
            guard let cell = detailTableView.dequeueReusableCell(
                withIdentifier: DetailTableViewCell.description(),
                for: indexPath
            ) as? DetailTableViewCell else { return UITableViewCell() }
            cell.configure(dish: dishes[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - Extension DetailViewController + UISearchBarDelegate

extension DetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            presenter?.changeState()
            if let dishes = presenter?.filterContentForSearchText(searchText, dishes: dishes) {
                self.dishes = dishes
                DispatchQueue.main.async {
                    self.detailTableView.reloadData()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        headerView.searchBar.resignFirstResponder()
    }
}

// MARK: - Extension DetailViewController + DetailTableViewCellDelegate

extension DetailViewController: DetailTableViewCellDelegate {
    func recipesCellDidTap(_ cell: DetailTableViewCell) {
        let recipeDetailTableView = RecipeDetailViewController()
        navigationController?.pushViewController(recipeDetailTableView, animated: true)
    }
}
