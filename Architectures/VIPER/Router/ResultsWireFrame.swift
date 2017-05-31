//
//  ResultsViewWireFrame.swift
//  Architectures
//
//  Created by Fabijan Bajo on 31/05/2017.
//
//

import UIKit

class ResultsWireFrame: ResultsWireFrameInterface {

    
    // MARK: - Methods
    
    // Wire up and construct project's root view (UITabbarController)
    class func constructResultsModule() -> UIViewController {
        // Configure containers
        let tabBarC = UITabBarController()
        let navC = UINavigationController(rootViewController: tabBarC)
        tabBarC.setViewControllers(
            [movieViewAfterConfiguration(),actorViewAfterConfiguration()],
            animated: false)
        navC.navigationBar.barStyle = .black
        tabBarC.tabBar.barStyle = .black
        return navC
    }
    
    // Show detailview from presenter
    func showDetail(from view: ResultsViewInterface, forPresentable object: Transportable) {
        let detailVC = DetailViewController()
        detailVC.presentableObject = object
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
    // MARK: - Helpers
    
    private class func movieViewAfterConfiguration() -> UIViewController {
        // Allocate movieVC's
        let movieResultsVC = ResultsViewController()
        let moviePresenter = ResultsPresenter()
        let movieInteractor = MovieResultsInteractor()
        moviePresenter.interactor = movieInteractor
        moviePresenter.view = movieResultsVC
        moviePresenter.wireFrame = ResultsWireFrame()
        movieInteractor.output = moviePresenter
        movieResultsVC.presenter = moviePresenter
        movieResultsVC.title = "Movies"
        return movieResultsVC
    }
    private class func actorViewAfterConfiguration() -> UIViewController {
        // Allocate actorVC's
        let actorResultsVC = ResultsViewController()
        let actorPresenter = ResultsPresenter()
        let actorInteractor = ActorResultsInteractor()
        actorPresenter.interactor = actorInteractor
        actorPresenter.view = actorResultsVC
        actorPresenter.wireFrame = ResultsWireFrame()
        actorInteractor.output = actorPresenter
        actorResultsVC.presenter = actorPresenter
        actorResultsVC.title = "Actors"
        return actorResultsVC
    }
}
