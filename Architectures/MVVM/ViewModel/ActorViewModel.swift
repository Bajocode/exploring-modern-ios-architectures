//
//  ActorViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 27/05/2017.
//
//

import Foundation

class ActorViewModel: ViewModel {
    
    
    // MARK: - Properties
    
    // Properties
    fileprivate var actors = [Actor]() { didSet { viewReload?() } }
    var count: Int { return actors.count }
    struct PresentableInstance: Parsable {
        let name: String
        let thumbnailURL: URL
        let fullSizeURL: URL
    }

    // Binds
    private var viewReload: (() -> Void)?
    private var showDetail: ((URL) -> Void)?
    
    // MARK: - Methods
    
    // Subscript: viewModel[i] -> PresentableInstance
    subscript (index: Int) -> Parsable { return presentableInstance(from: actors[index]) }
    
    // Initialize binds
    func bindModelUpdate(with viewReload: @escaping () -> Void) {
        self.viewReload = viewReload
    }
    func bindPresentation(with showDetail: @escaping (URL) -> Void) {
        self.showDetail = showDetail
    }
    
    func showDetail(at indexPath: IndexPath) {
        let movie = actors[indexPath.row]
        let presentable = presentableInstance(from: movie) as! PresentableInstance
        showDetail?(presentable.fullSizeURL)
    }
    
    
    
    // Fetch and parse model objects, bound to collectionview reload
    func fetchNewModelObjects() {
        DataManager.shared.fetchNewTmdbObjects(withType: .movie) { (result) in
            switch result {
            case let .success(parasables):
                self.actors = parasables as! [Actor]
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // Exposing data model objects for easy presenting and UI management
    func presentableInstance(from model: Parsable) -> Parsable {
        let actor = model as! Actor
        let thumbnailURL = TmdbAPI.tmdbImageURL(forSize: .thumb, path: actor.profilePath)
        let fullSizeURL = TmdbAPI.tmdbImageURL(forSize: .full, path: actor.profilePath)
        return PresentableInstance(name: actor.name, thumbnailURL: thumbnailURL, fullSizeURL: fullSizeURL)
    }
}


// MARK: - CellRepresentable

extension ActorViewModel: CollectionViewConfigurable {
    
    // MARK: - Properties
    
    // Required
    var cellID: String { return "ActorCell" }
    var widthDivisor: Double { return 3.0 }
    var heightDivisor: Double { return 3.0 }
    
    // Optional
    var interItemSpacing: Int? { return 8 }
    var lineSpacing: Int? { return 8 }
    var bottomInset: Int? { return 49 }
}
