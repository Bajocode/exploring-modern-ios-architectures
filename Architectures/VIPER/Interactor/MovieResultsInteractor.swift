//
//  MovieResultsInteractor.swift
//  Architectures
//
//  Created by Fabijan Bajo on 31/05/2017.
//
//

import Foundation

class MovieResultsInteractor: ResultsInteractorInterface {
    
    
    // MARK: - Properties
    
    weak var output: ResultsInteractorOutput!
    struct PresentableInstance: Transportable {
        let title: String
        let thumbnailURL: URL
        let fullSizeURL: URL
        let ratingText: String
        let releaseDateText: String
    }
    
    private let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    
    
    // MARK: - Methods
    
    // ResultsInteractorInterface
    func fetchNewObjects() {
        DataManager.shared.fetchNewTmdbObjects(withType: .movie) { (result) in
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
    private func presentableInstance(object: Transportable) -> Transportable {
        let movie = object as! Movie
        let thumbnailURL = TmdbAPI.tmdbImageURL(forSize: .thumb, path: movie.posterPath)
        let fullSizeURL = TmdbAPI.tmdbImageURL(forSize: .full, path: movie.posterPath)
        let ratingText = String(format: "%.1f", movie.averageRating)
        let dateObject = releaseDateFormatter.date(from: movie.releaseDate)
        let releaseDateText = releaseDateFormatter.string(from: dateObject!)
        return PresentableInstance(title: movie.title, thumbnailURL: thumbnailURL, fullSizeURL: fullSizeURL, ratingText: ratingText, releaseDateText: releaseDateText)
    }
}

extension MovieResultsInteractor: CollectionViewConfigurable {
    // Required
    var cellID: String { return "MovieCell" }
    var widthDivisor: Double { return 2.0 }
    var heightDivisor: Double { return 2.5 }
    
    // Optional
    var interItemSpacing: Double? { return 1 }
    var lineSpacing: Double? { return 1 }
    var bottomInset: Double? { return 49 }
}
