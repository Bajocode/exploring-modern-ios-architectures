//
//  Extensions.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import UIKit

extension UICollectionViewFlowLayout {
    
    convenience init(viewModel: CellRepresentable) {
        self.init()
        guard let bounds = collectionView?.bounds else { return }
        
        let width = bounds.width / CGFloat(viewModel.widthDivisor)
        let height = bounds.height / CGFloat(viewModel.heightDivisor)
        let size = CGSize(width: width, height: height)
        itemSize = size
        sectionInset = UIEdgeInsets(
            top: CGFloat(viewModel.verticalInsets ?? 0),
            left: CGFloat(viewModel.horizontalInsets ?? 0),
            bottom: CGFloat(viewModel.verticalInsets ?? 0),
            right: CGFloat(viewModel.horizontalInsets ?? 0)
        )
        minimumInteritemSpacing = CGFloat(viewModel.interItemSpacing ?? 0)
        minimumLineSpacing = CGFloat(viewModel.lineSpacing ?? 0)
    }
    
}
