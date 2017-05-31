//
//  ResultsPresenter.swift
//  Architectures
//
//  Created by Fabijan Bajo on 31/05/2017.
//
//

import Foundation

class ResultsPresenter: ResultsPresenterInterface, ResultsInteractorOutput {
    
    
    // MARK: - Properties
    
    weak var view: ResultsViewInterface!
    var interactor: ResultsInteractorInterface!
    
    
    
    // MARK: - Methods
    
    // ResultsPresenterInterface
    func updateView() {
        interactor.fetchNewObjects()
    }
    func collectionConfiguration() -> CollectionViewConfigurable {
        return interactor.createCollectionConfiguration()
    }
    
    // ResultsInteractorOutput
    func receive(presentableObjects: [Transportable]) {
        view.update(presentableObjects: presentableObjects)
    }
}
