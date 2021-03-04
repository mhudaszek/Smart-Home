//
//  UIViewController+Extensions.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 13/03/2021.
//

import UIKit

extension UIViewController {
    open func present(_ viewController: UIViewController, style: UIModalPresentationStyle, animated: Bool, completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = style
        present(viewController, animated: animated, completion: completion)
    }
}
