//
//  StackView.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 18/04/2021.
//

import UIKit

class StackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    func commonInit() {}
}
