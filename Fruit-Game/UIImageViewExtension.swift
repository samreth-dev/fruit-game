//
//  UIImageViewExtension.swift
//  Fruit-Game
//
//  Created by Samreth Kem on 12/4/22.
//

import UIKit

extension UIImageView {
    func setupWithinSafeArea(insects: UIEdgeInsets, bounds: CGRect) {
        let safeAreaLeading = insects.left
        let safeAreaTrailing = insects.right
        let safeAreaTop = insects.top
        let safeAreaBottom = insects.bottom
        let x = Int.random(in: 30 + Int(safeAreaLeading)...Int(bounds.maxX) - Int(safeAreaTrailing) - 30)
        let y = Int.random(in: (10 + Int(safeAreaTop))...(Int(bounds.maxY) - 80 - Int(safeAreaBottom)))
        self.frame = CGRect(x: x, y: y, width: 20, height: 20)
    }
}
