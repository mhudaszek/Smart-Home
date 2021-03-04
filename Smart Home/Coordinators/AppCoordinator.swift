//
//  AppCoordinator.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 02/03/2021.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {

    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var childCoordinators = [Coordinator]()

    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
    }

    func start() {


        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        let onboardingViewController = OnboardingViewController()
        onboardingViewController.coordinator = self
        rootViewController.navigationBar.isHidden = true
        rootViewController.setViewControllers([onboardingViewController],
                                              animated: true)
    }

    func removeOnboardingCoordinator() {
        childCoordinators.removeFirst()
    }

    func showHomeScreen() {
//        rootViewController.navigationBar.prefersLargeTitles = true
//        rootViewController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        let mainViewController = MainViewController()
        rootViewController.present(mainViewController,
                                   style: .fullScreen,
                                   animated: true)
    }
}
