//
//  LoginCoordinator.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 21/07/2021.
//

import UIKit

class LoginCoordinator: Coordinator {
    private var navigationController: UINavigationController
    private var loginViewController: LoginViewController!
    let viewModel = LoginViewModel()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loginViewController = LoginViewController(viewModel: viewModel)
    }

    func start() {
        navigationController.pushViewController(loginViewController, animated: false)
    }
}
