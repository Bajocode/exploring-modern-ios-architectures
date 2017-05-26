//
//  MovieViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//
/*
    MVVM ViewModels should not access UIKit
*/

import Foundation


class MovieViewModel: ViewModel {
    
    
    // MARK: - Properties
    
    fileprivate var movies = [Movie]() { didSet { didChange?() } }
    var count: Int { return movies.count }
    private var didChange: (() -> Void)?
    struct UIReadyInstance: Convertable {
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
    
    subscript (index: Int) -> Convertable { return uiReadyInstance(from: movies[index]) }
    func bind(didChange: @escaping () -> Void) {
        self.didChange = didChange
    }
    func fetchNewModelObjects() {
        DataManager.shared.fetchNewTmdbObjects(withType: .movie) { (result) in
            switch result {
            case let .success(convertables):
                self.movies = convertables as! [Movie]
            case let .failure(error):
                print(error)
            }
        }
    }
    // Exposing data model objects for easy presenting and UI management
    private func uiReadyInstance(from movie: Movie) -> UIReadyInstance {
        let thumbnailURL = TmdbAPI.tmdbImageURL(forSize: .thumb, path: movie.posterPath)
        let fullSizeURL = TmdbAPI.tmdbImageURL(forSize: .full, path: movie.posterPath)
        let ratingText = String(format: "%.1f", movie.averageRating)
        let dateObject = releaseDateFormatter.date(from: movie.releaseDate)
        let releaseDateText = releaseDateFormatter.string(from: dateObject!)
        return UIReadyInstance(title: movie.title, thumbnailURL: thumbnailURL, fullSizeURL: fullSizeURL, ratingText: ratingText, releaseDateText: releaseDateText)
    }
}


// MARK: - CellRepresentable

extension MovieViewModel: CollectionViewConfigurable {
    
    // MARK: - Properties
    
    // Required
    var cellID: String { return "MovieCell" }
    var widthDivisor: Double { return 2.0 }
    var heightDivisor: Double { return 2.5 }
    
    // Optional
    var interItemSpacing: Int? { return 1 }
    var lineSpacing: Int? { return 1 }
    var bottomInset: Int? { return 49 }
}

