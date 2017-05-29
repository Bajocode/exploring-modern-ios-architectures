//
//  ActorResultsPresenter.swift
//  Architectures
//
//  Created by Fabijan Bajo on 29/05/2017.
//
//

import Foundation

class ActorResultsPresenter: ResultsViewPresenter {
    
    
    // MARK: - Properties
    
    unowned private let view: ResultsView
    private var actors = [Actor]()
    var objectsCount: Int { return actors.count }
    struct PresentableInstance: Parsable {
        let name: String
        let thumbnailURL: URL
        let fullSizeURL: URL
        let cornerRadius: Double
    }
    
    
    // MARK: - Initializers
    
    required init(view: ResultsView) {
        self.view = view
    }
    
    
    // MARK: - Methods
    
    func presentableInstance(index: Int) -> Parsable {
        let actor = actors[index]
        let thumbnailURL = TmdbAPI.tmdbImageURL(forSize: .thumb, path: actor.profilePath)
        let fullSizeURL = TmdbAPI.tmdbImageURL(forSize: .full, path: actor.profilePath)
        return PresentableInstance(name: actor.name, thumbnailURL: thumbnailURL, fullSizeURL: fullSizeURL, cornerRadius: 15.0)
    }
    
    func presentNewObjects() {
        DataManager.shared.fetchNewTmdbObjects(withType: .actor) { (result) in
            switch result {
            case let .success(parsables):
                self.actors = parsables as! [Actor]
            case let .failure(error):
                print(error)
            }
            self.view.reloadCollectionData()
        }
    }
    
    func presentDetail(for indexPath: IndexPath) {
        let presentable = presentableInstance(index: indexPath.row) as! PresentableInstance
        let vc = DetailViewController()
        vc.imageURL = presentable.fullSizeURL
        vc.navigationItem.title = presentable.name
        view.show(vc)
    }
}


// MARK: - CollectionViewConfigurable
extension ActorResultsPresenter: CollectionViewConfigurable {
    
    // MARK: - Properties
    
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
