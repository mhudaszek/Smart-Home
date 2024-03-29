//
//  MainViewController+Tab.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 03/03/2021.
//

import UIKit

extension MainViewController {
    enum Tab: Int, CaseIterable {
        case live
        case vibrate
        case mediate
        case more

        var rootViewController: UIViewController? {
            var rootViewController = UIViewController()
            switch self {
            case .live:
                break
//                let homeViewModel = HomeViewModel(service: WeatherService())
//                let homeViewController = HomeViewController(viewModel: homeViewModel)
//                rootViewController = UINavigationController(rootViewController: homeViewController)
//                rootViewController = getNavigationController(rootViewController: homeViewController)
            default:
                break
            }
            rootViewController.tabBarItem = tabBarItem
            return rootViewController
        }

        private var tabBarItem: UITabBarItem {
            switch self {
            case .live:
                return UITabBarItem(title: "test",
                                    image: nil,
                                    tag: 0)
            default:
                return UITabBarItem(title: "test",
                                    image: nil,
                                    tag: 0)
            }
        }

        private func getNavigationController(rootViewController: UIViewController) -> UINavigationController {
            let navigationController = UINavigationController(rootViewController: rootViewController)
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.barTintColor = .white
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]

            navigationController.navigationBar.setBackgroundImage(UIImage(), for:.default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.layoutIfNeeded()
            return navigationController
        }
    }

    func getTabBarItemTitles() -> [String] {
        return ["test"]
    }
}
