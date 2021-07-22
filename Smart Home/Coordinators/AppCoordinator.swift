//
//  AppCoordinator.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 02/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol Coordinator {
    func start()
}

enum CoordinatorTypes {
    case login
    case home
}

class AppCoordinator: Coordinator {
    private let rootViewController: UINavigationController
//    private var childCoordinators = [Coordinator]()
    private var childCoordinators: [CoordinatorTypes: Coordinator] = [:]
    let disposeBag = DisposeBag()

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        showLaunchScreen()
    }
// wywalić!!
//    func removeOnboardingCoordinator() {
////        childCoordinators.removeFirst()
//    }
}

extension AppCoordinator {
    func add(coordinator: Coordinator?, type: CoordinatorTypes) {
        childCoordinators[type] = coordinator
    }

    func free(coordinator type: CoordinatorTypes) {
        childCoordinators = childCoordinators.filter { $0.key != type }
    }
}

private extension AppCoordinator {
    func showLaunchScreen() {
        let onboardingViewController = OnboardingViewController()
        setupOnboardingRx(vc: onboardingViewController)
        rootViewController.navigationBar.isHidden = true
        onboardingViewController.navigationItem.setHidesBackButton(true, animated: false)
        rootViewController.pushViewController(onboardingViewController, animated: true)
    }

    func setupOnboardingRx(vc: OnboardingViewController) {
        vc.closeOnboarding
            .subscribe(with: self, onNext: { owner, steps in
                LocationService.shared.start()
//                owner.showSignInScreen()
                owner.showHomeScreen()
            }).disposed(by: disposeBag)
    }
}

private extension AppCoordinator {
    func showHomeScreen() {
        let homeCoordinator = HomeCoordinator(navigationController: rootViewController)
        add(coordinator: homeCoordinator, type: .home)
        homeCoordinator.start()
    }
}

private extension AppCoordinator {
    func showSignInScreen() {
        let loginCoordinator = LoginCoordinator(navigationController: rootViewController)
        add(coordinator: loginCoordinator, type: .login)
        loginCoordinator.start()
        setupRx(vm: loginCoordinator.viewModel)
    }

    func setupRx(vm: LoginViewModel) {
        vm.loginSucceeded
            .subscribe(with: self, onNext: { owner, userId in
                owner.showHomeScreen()
            }).disposed(by: disposeBag)
    }
}
