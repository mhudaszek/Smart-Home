//
//  HomeViewController.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 18/04/2021.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let userId: String

    init(navigationController: UINavigationController, userId: String) {
        self.navigationController = navigationController
        self.userId = userId
    }

    func start() {
        let homeViewModel = HomeViewModel(service: WeatherService(),
                                          userId: userId)
         let homeViewController = HomeViewController(viewModel: homeViewModel)
 //        homeViewController.coordinator = self
         navigationController.pushViewController(homeViewController, animated: false)
         
//        let vm = LoginViewModel()
//        let vc = LoginViewController(viewModel: vm)
//        navigationController.pushViewController(vc, animated: false)
    }
//deviceDetailsViewModel:
//    func showDeviceDetails(deviceViewModel: DeviceViewModel) {
//        let deviceDetailsViewModel = DeviceDetailsViewModel(device: deviceViewModel, session: session)
//        let deviceDetailsViewController = DeviceDetailsViewController(viewModel: deviceDetailsViewModel)
//        deviceDetailsViewController.hidesBottomBarWhenPushed = true
//        navigationController.pushViewController(deviceDetailsViewController, animated: true)
//    }

//    @objc
//       func quitButtonTapped() {
//           print("aa")
//       }

}
