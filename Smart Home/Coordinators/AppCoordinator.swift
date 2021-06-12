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

class AppCoordinator: Coordinator {
    private let rootViewController: UINavigationController
    private var childCoordinators = [Coordinator]()
    let disposeBag = DisposeBag()

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        showLaunchScreen()
    }

    func removeOnboardingCoordinator() {
        childCoordinators.removeFirst()
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
                owner.showHome()
            }).disposed(by: disposeBag)
    }

    func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: rootViewController)
        homeCoordinator.start()
    }
}
