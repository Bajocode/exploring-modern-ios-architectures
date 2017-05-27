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
    
    // Properties
    fileprivate var movies = [Movie]() { didSet { viewReload?() } }
    var count: Int { return movies.count }
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
    // Binds
    private var viewReload: (() -> Void)?
    private var showDetail: ((URL) -> Void)?
    
    // MARK: - Methods
    
    // Subscript: viewModel[i] -> PresentableInstance
    subscript (index: Int) -> Parsable { return presentableInstance(from: movies[index]) }
    
    // Initialize binds
    func bindModelUpdate(with viewReload: @escaping () -> Void) {
        self.viewReload = viewReload
    }
    func bindPresentation(with showDetail: @escaping (URL) -> Void) {
        self.showDetail = showDetail
    }
    
    func showDetail(at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let presentable = presentableInstance(from: movie) as! PresentableInstance
        showDetail?(presentable.fullSizeURL)
    }



    // Fetch and parse model objects, bound to collectionview reload 
    func fetchNewModelObjects() {
        DataManager.shared.fetchNewTmdbObjects(withType: .movie) { (result) in
            switch result {
            case let .success(parasables):
                self.movies = parasables as! [Movie]
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // Exposing data model objects for easy presenting and UI management
    func presentableInstance(from model: Parsable) -> Parsable {
        let movie = model as! Movie
        let thumbnailURL = TmdbAPI.tmdbImageURL(forSize: .thumb, path: movie.posterPath)
        let fullSizeURL = TmdbAPI.tmdbImageURL(forSize: .full, path: movie.posterPath)
        let ratingText = String(format: "%.1f", movie.averageRating)
        let dateObject = releaseDateFormatter.date(from: movie.releaseDate)
        let releaseDateText = releaseDateFormatter.string(from: dateObject!)
        return PresentableInstance(title: movie.title, thumbnailURL: thumbnailURL, fullSizeURL: fullSizeURL, ratingText: ratingText, releaseDateText: releaseDateText)
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

