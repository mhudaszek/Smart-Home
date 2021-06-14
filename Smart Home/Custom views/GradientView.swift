//
//  GradientView.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 15/06/2021.
//

import UIKit

class GradientView: View {
    private let gradient = CAGradientLayer()

    override func setup() {
        super.setup()
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }

    override public func layoutSubviews() {
        gradient.frame = bounds
    }

    func set(gradientColors: [UIColor]) {
        gradient.colors = gradientColors.map { $0.cgColor }
    }
}
