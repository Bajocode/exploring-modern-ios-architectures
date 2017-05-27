//
//  ViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import Foundation

protocol ViewModel: class, CollectionViewConfigurable {
    
    
    // MARK: - Properties
    
    var count: Int { get }
    
    
    // MARK: - Methods
    
    // Second conversion: Model -> UIReadyInstance
    subscript (index: Int) -> Parsable { get }
    
    // Binds
    func bindModelUpdate(with viewReload: @escaping () -> Void)
    func bindPresentation(with showDetail: @escaping (URL) -> Void)
    
    // Invoked by View
    func fetchNewModelObjects()
    func showDetail(at indexPath: IndexPath)
    
    // Generate single presentable instance from raw model
    func presentableInstance(from model: Parsable) -> Parsable
}

