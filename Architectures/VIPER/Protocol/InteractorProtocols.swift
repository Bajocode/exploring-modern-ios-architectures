//
//  InteractorProtocols.swift
//  Architectures
//
//  Created by Fabijan Bajo on 31/05/2017.
//
//
/*
    INTERACTOR
    - Contains business logic as specified by a use case
    - The work done in an Interactor should be independent of any UI
*/

import Foundation

// An interface for the Presenter to fetch & receive new model objects
protocol ResultsInteractorInterface {
    func fetchNewObjects()
    func createCollectionConfiguration() -> CollectionViewConfigurable
    func presentableInstance(object: Transportable) -> Transportable
}
protocol ResultsInteractorOutput: class {
    func receive(presentableObjects: [Transportable])
}
