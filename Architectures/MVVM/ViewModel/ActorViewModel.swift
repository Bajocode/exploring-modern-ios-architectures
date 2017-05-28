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
    fileprivate var actors = [Actor]() { didSet { modelUpdate?() } }
    var count: Int { return actors.count }
    struct PresentableInstance: Parsable {
        let name: String
        let thumbnailURL: URL
        let fullSizeURL: URL
    }

    
    // MARK: - Binds
    
    typealias modelUpdateClosure = () -> Void
    typealias showDetailClosure = (URL, String) -> Void
    
    // Bind model updates and collectionview reload
    private var modelUpdate: modelUpdateClosure?
    func bindViewReload(with modelUpdate: @escaping modelUpdateClosure) {
        self.modelUpdate = modelUpdate
    }
    func fetchNewModelObjects() {
        DataManager.shared.fetchNewTmdbObjects(withType: .actor) { (result) in
            switch result {
            case let .success(parsables):
                self.actors = parsables as! [Actor]
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // Bind collectionviewDidTap and detailVC presentation
    private var showDetail: showDetailClosure?
    func bindPresentation(with showDetail: @escaping showDetailClosure) {
        self.showDetail = showDetail
    }
    func showDetail(at indexPath: IndexPath) {
        let actor = actors[indexPath.row]
        let presentable = presentableInstance(from: actor) as! PresentableInstance
        showDetail?(presentable.fullSizeURL, presentable.name)
    }

    
    // MARK: - Helpers
    
    // Subscript: viewModel[i] -> PresentableInstance
    subscript (index: Int) -> Parsable { return presentableInstance(from: actors[index]) }
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
    var cornerRadius: Double? { return 20.0 }
}
