//
//  TabBarViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

class TabBarViewController: UITabBarController {

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        configureViewControllers()
    }
    
    
    // MARK: - Methods
    
    private func configureViewControllers() {
        // Configure movieResultsVC
        let movieResultsVC = ResultsViewController()
        movieResultsVC.title = "Recent Movies"
        DataManager.shared.fetchNewTmdbObjects(withType: .movie) { (result) in
            switch result {
            case let .success(movies):
                movieResultsVC.data = movies.map { MovieViewModel(movie: $0 as! Movie) }
            case let .failure(error):
                print(error)
            }
        }
        
        // Configure actorResultsVC
        let actorResultsVC = ResultsViewController()
        actorResultsVC.title = "Popular Actors"
        
        // Set the tabbar items
        setViewControllers([movieResultsVC, actorResultsVC], animated: false)
    }
}


extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard
            let actorResultsVC = viewController as? ResultsViewController,
            actorResultsVC.data.isEmpty else {
            return
        }
        DataManager.shared.fetchNewTmdbObjects(withType: .actor) { (result) in
            switch result {
            case let .success(actors):
                actorResultsVC.data = actors.map { ActorViewModel(actor: $0 as! Actor) }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}


