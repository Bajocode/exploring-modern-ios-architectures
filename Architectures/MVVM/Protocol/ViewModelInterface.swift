//
//  ViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import Foundation

protocol ViewModelInterface: class, CollectionViewConfigurable {
    
    
    // MARK: - Properties
    
    var count: Int { get }
    
    
    // MARK: - Methods
    
    subscript (index: Int) -> Transportable { get }
    
    // Binds
    func bindViewReload(with modelUpdate: @escaping () -> Void)
    func bindPresentation(with showDetail: @escaping (URL, String) -> Void)
    
    // Invoked by View
    func fetchNewModelObjects()
    func showDetail(at indexPath: IndexPath)
    
    // Single presentable instance from raw model
    func presentableInstance(from model: Transportable) -> Transportable
}

