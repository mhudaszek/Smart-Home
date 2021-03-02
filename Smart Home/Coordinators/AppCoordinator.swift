//
//  AppCoordinator.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 02/03/2021.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewController()
        navigationController.setViewControllers([vc], animated: true)
    }

    func removeOnboardingCoordinator() {
        childCoordinators.removeFirst()
    }
}
