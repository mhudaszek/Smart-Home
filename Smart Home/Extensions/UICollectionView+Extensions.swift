//
//  UICollectionView+Extensions.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import UIKit

extension UICollectionView {
    func register<CellType: UICollectionViewCell>(_ type: CellType.Type) where CellType: Reusable {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }

    func dequeueCell<CellType: UICollectionViewCell>(_ type: CellType.Type, at indexPath: IndexPath) -> CellType where CellType: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? CellType else {
            fatalError("Could not dequeue cell of type \(CellType.self) with reuseIdentifier \(CellType.reuseIdentifier)")
        }
        return cell
    }
}
