// SortingButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class SortingButton: UIButton {
    // MARK: - Enum

    private enum Constants {
        static let greenButtonColor = "AppGreen"
        static let grayButtonColor = "AppSearchColor"
        static let upStack = "up_stack"
        static let downStack = "down_stack"
        static let fontVerdana = "Verdana"
    }

    /// Энум для определения состояния кнопки
    enum StateButton {
        /// Текущее  состояние - не вsбрано
        case none
        /// Состояние по возрастанию
        case ascending
        /// Состояние по убыванию
        case descending
    }

    private var currentState: StateButton = .none {
        didSet {
            updateUI()
        }
    }

    private let normalImage = UIImage(named: Constants.upStack)?.withTintColor(.black, renderingMode: .alwaysOriginal)
    private let ascendingImage = UIImage(named: "up_stack")?
        .withTintColor(UIColor(named: Constants.grayButtonColor)!, renderingMode: .alwaysOriginal)
    private let descendingImage = UIImage(named: "down_stack")?
        .withTintColor(UIColor(named: Constants.grayButtonColor)!, renderingMode: .alwaysOriginal)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        titleLabel?.font = UIFont(name: Constants.fontVerdana, size: 18)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        currentState = .none
    }

    @objc private func buttonTapped() {
        switch currentState {
        case .none:
            currentState = .ascending
        case .ascending:
            currentState = .descending
        case .descending:
            currentState = .none
        }
    }

    private func updateUI() {
        switch currentState {
        case .none:
            backgroundColor = UIColor(named: Constants.grayButtonColor)
            setImage(normalImage, for: .normal)
            setTitleColor(.black, for: .normal)
        case .ascending:
            backgroundColor = UIColor(named: Constants.greenButtonColor)
            setImage(ascendingImage, for: .normal)
            setTitleColor(UIColor(named: Constants.grayButtonColor), for: .normal)
        case .descending:
            backgroundColor = UIColor(named: Constants.greenButtonColor)
            setImage(descendingImage, for: .normal)
            setTitleColor(UIColor(named: Constants.grayButtonColor), for: .normal)
        }
    }
}
