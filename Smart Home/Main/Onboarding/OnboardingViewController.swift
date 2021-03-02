//
//  OnboardingViewController.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 02/03/2021.
//

import UIKit

class OnboardingViewController: ViewController {
    private let onboardingView = OnboardingView()

    override func loadView() {
        view = onboardingView
    }

    override func setup() {
        super.setup()
        startAnimating()
    }
}

private extension OnboardingViewController {
    func startAnimating() {
        if !onboardingView.animationView.isAnimationPlaying {
            onboardingView.animationView.loopMode = .playOnce
            onboardingView.animationView.play { [weak self] _ in
//                self?.coordinator?.coordinateToTabBar()
            }
        }
    }
}
