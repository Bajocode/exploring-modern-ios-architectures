//
//  ResultsViewPresenter.swift
//  Architectures
//
//  Created by Fabijan Bajo on 29/05/2017.
//
//

import Foundation

protocol ResultsViewPresenter: CollectionViewConfigurable {
    
    
    // MARK: - Properties
    
    var objectsCount: Int { get }
    
    // MARK: - Initializers
    
    init(view: ResultsView)
    
    
    // MARK: - Methods
    
    func presentableInstance(index: Int) -> Transportable
    func presentNewObjects()
    func presentDetail(for indexPath: IndexPath)
}
