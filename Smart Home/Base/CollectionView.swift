//
//  CollectionView.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import UIKit

class CollectionView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
