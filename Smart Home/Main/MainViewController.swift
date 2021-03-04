//
//  MainViewController.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 03/03/2021.
//

import UIKit

class MainViewController: UITabBarController {
    private var tabBarItemTitles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
        tabBarItemTitles = getTabBarItemTitles()
    }
}

private extension MainViewController {
    func setupTabBar() {
        viewControllers = Tab.allCases.compactMap { $0.rootViewController }
        tabBar.barTintColor = .white
//        UITabBar.appearance().tintColor = .selectedTabBarItem
//        tabBar.unselectedItemTintColor = .unselectedTabBarItem
        self.delegate = self
    }
}

extension MainViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabBarItems = tabBar.items else { return }
        tabBarItems.forEach { $0.title = "" }
        tabBarItems[item.tag].title = tabBarItemTitles[item.tag]
    }
}
