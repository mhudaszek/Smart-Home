//
//  ViewController.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 01/03/2021.
//

import UIKit

class ViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        setupProperties()
//        setupSubviews()
//        setupConstraints()
    }

    func setup() {}
//    func setupProperties() {}
//    func setupSubviews() {}
//    func setupConstraints() {}

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
