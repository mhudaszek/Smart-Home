//
//  View.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 02/03/2021.
//

import UIKit

class View: UIView {

    init() {
        super.init(frame: .zero)
        setup()
    }

    func setup() {}

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
