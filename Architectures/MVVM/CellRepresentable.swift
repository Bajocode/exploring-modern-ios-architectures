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
    
    var cellProportion: CellProportion { get }
    var objectID: Int { get }
    var imageURL: URL { get }
    var cellID: String { get }
    
    
    // MARK: - Methods
    
    func cellInstance(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func updateCellImage(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath)
}
