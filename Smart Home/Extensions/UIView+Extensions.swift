//
//  UIView+Extensions.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 04/03/2021.
//

import UIKit

extension UIView {
    func activateConstraints(with subView: UIView, left: CGFloat = 0, top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        guard subviews.contains(subView) else { return }
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: left),
            subView.topAnchor.constraint(equalTo: topAnchor, constant: top),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -right),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottom)
        ])
    }
}
