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
    subscript (index: Int) -> Convertable { get }
    
    // Bind vieModel updates to view events (MVVM crux)
    func bind(didChange: @escaping () -> Void)

    // Fetch raw data model objects
    func fetchNewModelObjects()
}

