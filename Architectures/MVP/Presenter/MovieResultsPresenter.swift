//
//  MovieResultsPresenter.swift
//  Architectures
//
//  Created by Fabijan Bajo on 29/05/2017.
//
//

import Foundation

class MovieResultsPresenter: ResultsViewPresenter {
    
    
    // MARK: - Properties
    
    unowned private let view: ResultsView
    private var movies = [Movie]()
    var objectsCount: Int { return movies.count }
    struct PresentableInstance: Parsable {
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
    
    
    // MARK: - Initializers
    
    required init(view: ResultsView) {
        self.view = view
    }
    
    
    // MARK: - Methods
    
    func presentableInstance(index: Int) -> Parsable {
        let movie = movies[index]
        let thumbnailURL = TmdbAPI.tmdbImageURL(forSize: .thumb, path: movie.posterPath)
        let fullSizeURL = TmdbAPI.tmdbImageURL(forSize: .full, path: movie.posterPath)
        let ratingText = String(format: "%.1f", movie.averageRating)
        let dateObject = releaseDateFormatter.date(from: movie.releaseDate)
        let releaseDateText = releaseDateFormatter.string(from: dateObject!)
        return PresentableInstance(title: movie.title, thumbnailURL: thumbnailURL, fullSizeURL: fullSizeURL, ratingText: ratingText, releaseDateText: releaseDateText)
    }
    
    func presentNewObjects() {
        DataManager.shared.fetchNewTmdbObjects(withType: .movie) { (result) in
            switch result {
            case let .success(parsables):
                self.movies = parsables as! [Movie]
            case let .failure(error):
                print(error)
            }
            self.view.reloadCollectionData()
        }
    }
    
}
