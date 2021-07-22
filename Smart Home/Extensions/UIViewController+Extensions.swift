//
//  UIViewController+Extensions.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 13/03/2021.
//

import UIKit

typealias AlertAction = (UIAlertAction) -> Void

struct AlertConfig {
    var title: String
    var message: String
    var okAction: UIAlertAction?
    var cancelAction: UIAlertAction
}

extension UIViewController {
    open func present(_ viewController: UIViewController, style: UIModalPresentationStyle, animated: Bool, completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = style
        present(viewController, animated: animated, completion: completion)
    }

    func showAlert(alertConfig: AlertConfig) {
        let alertController = UIAlertController(title: alertConfig.title,
                                                message: alertConfig.message,
                                                preferredStyle: .alert)
        if let okAction = alertConfig.okAction {
            alertController.addAction(okAction)
        }
        alertController.addAction(alertConfig.cancelAction)
        present(alertController, animated: true)
    }
}
