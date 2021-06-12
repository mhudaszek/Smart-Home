//
//  OnboardingView.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 02/03/2021.
//
import UIKit
import Lottie

class OnboardingView: View {

    let animationView: AnimationView

    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    override init() {
        animationView = AnimationView(name: "lamp-outline")
        super.init()
    }
}

private extension OnboardingView {
    func addSubviews() {
        addSubview(animationView)
    }

    func setupConstraints() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 350),
            animationView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }

    func startAnimating() {
        if !animationView.isAnimationPlaying {
            animationView.loopMode = .loop
            animationView.play()
        }
    }
}

