//
//  ResultsViewPresenter.swift
//  Architectures
//
//  Created by Fabijan Bajo on 29/05/2017.
//
//

import Foundation

protocol ResultsViewPresenter {
    
    
    // MARK: - Properties
    
    var objectsCount: Int { get }
    
    
    // MARK: - Initializers
    
    init(view: ResultsView)
    
    
    // MARK: - Methods
    
    func presentableInstance(index: Int) -> Parsable
    func presentNewObjects()
}
