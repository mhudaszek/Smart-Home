//
//  UnderlineSwitch.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 18/04/2021.
//  Copyright © 2021 Miquido. All rights reserved.
//

import UIKit

class UnderlineSwitchView: View {
    private let underlineSwitch = UnderlineSwitch()
    private let scrollView = UIScrollView()
    private let viewModel: UnderlineSwitchViewModel

    init(viewModel: UnderlineSwitchViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func setup() {
        super.setup()
        addSubviews()
        setupConstraints()
        underlineSwitch.setup(with: viewModel.titles)
    }

    func switchToIndex(index: Int) {
        underlineSwitch.switchToIndex(index)
    }
}

private extension UnderlineSwitchView {
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(underlineSwitch)
    }

    func setupConstraints() {
        activateConstraints(with: scrollView)
        scrollView.activateConstraints(with: underlineSwitch)
        NSLayoutConstraint.activate([
            underlineSwitch.heightAnchor.constraint(equalTo: underlineSwitch.heightAnchor)
        ])
    }
}

class UnderlineSwitch: StackView {
    private var buttons = [UIButton]()
    private let selectionUnderlineView = UIView()
    private var selectionXConstraints = [NSLayoutConstraint]()
    private var selectionUnderlineHeightConstraint: NSLayoutConstraint?
    private var currentSelection = 0
    var switchTappedCompletion: ((Int) -> Void)?

    override func commonInit() {
        super.commonInit()
        setupStackView()
    }

    func setup(with titles: [String]) {
        addButtons(titles: titles)
        setupSelectionUnderlineView()
    }

    func switchToIndex(index: Int) {
        switchToIndex(index)
    }
}

private extension UnderlineSwitch {
    func setupStackView() {
//        distribution = .fillEqually
//        axis = .horizontal
//        spacing = 0
//        alignment = .center

        distribution = .fillEqually
        spacing = 5
        axis = .horizontal
        alignment = .fill
    }

    func addButtons(titles: [String]) {
        let buttons = titles.enumerated().map { (index, title) -> UIButton in
            let pointSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .callout).pointSize
            let button = UIButton(type: .system)
            if index == 0 {
//                button.titleLabel?.font = .regular(size: pointSize)
                button.accessibilityTraits.formUnion([.selected])
                button.setTitleColor(.red, for: .normal)
            } else {
//                button.titleLabel?.font = .regular(size: pointSize)
                button.setTitleColor(.lightGray, for: .normal)
            }
            button.titleLabel?.adjustsFontForContentSizeCategory = true
            button.setTitle(title, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            return button
        }

        buttons.forEach { button in
            addArrangedSubview(button)
        }

        self.buttons = buttons
    }

    @objc func buttonTapped(button: UIButton) {
        currentSelection = button.tag
        switchTappedCompletion?(currentSelection)
        switchToIndex(button.tag)
    }

    func setupSelectionUnderlineView() {
        selectionUnderlineView.translatesAutoresizingMaskIntoConstraints = false
        selectionUnderlineView.backgroundColor = .yellow
            //.pinkColor
        selectionUnderlineView.layer.cornerRadius = 3
        addSubview(selectionUnderlineView)

        selectionXConstraints = buttons.map { $0.centerXAnchor.constraint(equalTo: selectionUnderlineView.centerXAnchor) }

        selectionXConstraints.first?.isActive = true
        NSLayoutConstraint.activate([
            selectionUnderlineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectionUnderlineView.widthAnchor.constraint(equalToConstant: frame.width / 2),
        ])

        selectionUnderlineHeightConstraint = selectionUnderlineView.heightAnchor.constraint(equalToConstant: UIFont.preferredFont(forTextStyle: .headline).lineHeight / 7.0)
        selectionUnderlineHeightConstraint?.isActive = true
    }

    func switchToIndex(_ index: Int, animated: Bool = true) {
        currentSelection = index
        selectionXConstraints.forEach { constraint in
            constraint.isActive = false
        }
        selectionXConstraints[currentSelection].isActive = true

        UIView.transition(with: buttons[index], duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.buttons.forEach { button in
                button.setTitleColor(.lightGray, for: .normal)
            }
            self.buttons[index].setTitleColor(.yellow, for: .normal)
        },completion: nil)

        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: { [weak self] in
                self?.layoutIfNeeded()
            })
        } else {
            layoutIfNeeded()
        }

        let pointSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .callout).pointSize
        arrangedSubviews.forEach { view in
            guard let button = view as? UIButton else { return }
//            button.titleLabel?.font = .regular(size: pointSize)
            button.accessibilityTraits.formIntersection([.button])
        }

        let button = subviews.first(where: { ($0 as? UIButton)?.tag == currentSelection }) as? UIButton
//        button?.titleLabel?.font = .medium(size: pointSize)
        button?.accessibilityTraits.formUnion([.selected])
    }
}

