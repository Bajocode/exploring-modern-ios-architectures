//
//  Extensions.swift
//  Architectures
//
//  Created by Fabijan Bajo on 29/05/2017.
//
//

import UIKit


// MARK: - UICollectionViewFlowLayout

extension UICollectionViewFlowLayout {
    // Inits layout with equal spacing for all insets and itemspacings
    convenience init(viewModel: CollectionViewConfigurable, bounds: CGRect) {
        self.init()
        // Define values
        let spacing = CGFloat(viewModel.interItemSpacing ?? 0)
        let bottomInset = CGFloat(viewModel.bottomInset ?? 0)
        let widthDivisor = CGFloat(viewModel.widthDivisor)
        let heightDivisor = CGFloat(viewModel.heightDivisor)
        self.itemSize = UICollectionViewFlowLayout.itemSizeWithSingleSpacing(
            with: spacing,
            bottomInset: bottomInset,
            widthDivisor: widthDivisor,
            heightDivisor: heightDivisor,
            bounds: bounds)
        
        // Configure insets
        sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: bottomInset,
            right: spacing
        )
        minimumInteritemSpacing = spacing
        minimumLineSpacing = spacing
    }
}
