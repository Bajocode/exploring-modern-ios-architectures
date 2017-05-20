//
//  CellRepresentable.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

protocol CellRepresentable {
    
    
    // MARK: - Properties
    
    var objectID: Int { get }
    var thumbImageURL: URL { get }
    var cellID: String { get }
    var cornerRadius: CGFloat? { get }
    
    
    // MARK: - Methods
    
    func cellSize(withBounds bounds: CGRect) -> CGSize
    func cellInstance(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func updateCellImage(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath)
}
