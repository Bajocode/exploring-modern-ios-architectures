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
    convenience init(allSpacingEqualFor viewModel: CollectionViewConfigurable, bounds: CGRect) {
        self.init()
        // Define values
        let spacing = CGFloat(viewModel.interItemSpacing ?? 0)
        let tabBarInset = CGFloat(viewModel.bottomInset ?? 0)
        let widthDivisor = CGFloat(viewModel.widthDivisor)
        let heightDivisor = CGFloat(viewModel.heightDivisor)
        
        // Itemsize (if all spacing / insets are equal)
        let fullWspace = (widthDivisor + 1) * spacing
        let fullHspace = (heightDivisor + 1) + spacing
        let width = (bounds.width - fullWspace) / widthDivisor
        let height = (bounds.height - fullHspace) / heightDivisor
        self.itemSize = CGSize(width: width, height: height)
        
        // Configure insets
        sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: tabBarInset,
            right: spacing
        )
        minimumInteritemSpacing = spacing
        minimumLineSpacing = spacing
    }
}
