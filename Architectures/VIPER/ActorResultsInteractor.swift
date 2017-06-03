//
//  ActorResultsInteractor.swift
//  Architectures
//
//  Created by Fabijan Bajo on 31/05/2017.
//
//

import Foundation


class ActorResultsInteractor: ResultsInteractorInterface {
    
    
    // MARK: - Properties
    
    weak var output: ResultsInteractorOutput!
    struct PresentableInstance: Transportable {
        let name: String
        let thumbnailURL: URL
        let fullSizeURL: URL
        let cornerRadius: Double
    }
    
    
    // MARK: - Methods
    
    // ResultsInteractorInterface
    func fetchNewObjects() {
        DataManager.shared.fetchNewTmdbObjects(withType: .actor) { (result) in
            switch result {
            case let .success(objects):
                let presentables = objects.map { self.presentableInstance(object: $0) }
                self.output.receive(presentableObjects: presentables)
            case let .failure(error):
                print(error)
            }
        }
    }
    func createCollectionConfiguration() -> CollectionViewConfigurable {
        return self
    }
    
    // Convert plain model object to presentable abstractions
    func presentableInstance(object: Transportable) -> Transportable {
        let actor = object as! Actor
        let thumbnailURL = TmdbAPI.tmdbImageURL(forSize: .thumb, path: actor.profilePath)
        let fullSizeURL = TmdbAPI.tmdbImageURL(forSize: .full, path: actor.profilePath)
        return PresentableInstance(name: actor.name, thumbnailURL: thumbnailURL, fullSizeURL: fullSizeURL, cornerRadius: 10.0)
    }
}


// MARK: - CollectionViewConfigurable

extension ActorResultsInteractor: CollectionViewConfigurable {
    
    // Required
    var cellID: String { return "ActorCell" }
    var widthDivisor: Double { return 3.0 }
    var heightDivisor: Double { return 3.0 }
    
    // Optional
    var interItemSpacing: Double? { return 8 }
    var lineSpacing: Double? { return 8 }
    var topInset: Double? { return 8 }
    var horizontalInsets: Double? { return 8 }
    var bottomInset: Double? { return 49 }
}
