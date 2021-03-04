//
//  CollectionViewCell.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setup()
        setupProperties()
        setupViewHierarchy()
        setupLayoutConstraints()
    }

    func setup() {}
    func setupProperties() {}
    func setupViewHierarchy() {}
    func setupLayoutConstraints() {}
}

extension CollectionViewCell: Reusable {}

