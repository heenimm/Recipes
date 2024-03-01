// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI
import UIKit

struct ViewControllerPreview: UIViewControllerRepresentable {
    let viewControllerGenerator: () -> UIViewController
    init(viewControllerGenerator: @escaping () -> UIViewController) {
        self.viewControllerGenerator = viewControllerGenerator
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        viewControllerGenerator()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

///
final class DetailViewController: UIViewController {
    // MARK: - Enums

    private enum Constants {
        static let titleText = "Fish"
        static let fontVerdana = "Verdana"
        static let leftInset = UIScreen.main.bounds.width / 2 - 80
    }

    // MARK: - Public Properties

    weak var presenter: DetailPresenter?

    // MARK: - Visual Components

    private var detailTableView: UITableView!
    private var dishes = Dish.allFoods()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setupTableView()
        setupNavigationItem()
    }

    // MARK: - Private Methods

    private func setupNavigationItem() {
//        let arrow = UIBarButtonItem(
        ////            image: UIImage(systemName: "arrow").withRenderingMode(.alwaysOriginal),
//            style: .done,
//            target: nil,
//            action: nil
//        )
//        navigationItem.leftBarButtonItem = arrow
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    private func setTitle() {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 28)
        label.textColor = .black
        label.text = Constants.titleText

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }

    private func setupTableView() {
        detailTableView = UITableView()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.backgroundColor = .white
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        detailTableView.separatorStyle = .none

        detailTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseID)
        detailTableView.tableHeaderView = HeaderCell(frame: CGRect(
            origin: .zero,
            size: CGSize(width: 100, height: 100)
        ))

        view.addSubview(detailTableView)

        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Extension DetailViewController + UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
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
        dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailTableView.dequeueReusableCell(
            withIdentifier: DetailTableViewCell.reuseID,
            for: indexPath
        ) as? DetailTableViewCell else { return UITableViewCell() }

        cell.configure(dish: dishes[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            DetailViewController()
        }.edgesIgnoringSafeArea(.all)
    }
}
