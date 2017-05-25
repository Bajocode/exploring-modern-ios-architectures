//
//  ViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import Foundation

protocol ViewModel: class, CellRepresentable {
    
    
    // MARK: - Properties
    
    // Access ViewModel as a collection member
    subscript (index: Int) -> URL? { get }
    
    var count: Int { get }
    
    // MARK: - Methods
    
    // Bind vieModel updates to view events (MVVM crux)
    func bind(didChange: @escaping () -> Void)
    
    func fetchNewModelObjects()
}
