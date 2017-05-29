//
//  AppDelegate.swift
//  MVP
//
//  Created by Fabijan Bajo on 28/05/2017.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize the window (not using Storyboards)
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Allocate navigation controller and tabbar
        let tabBarC = UITabBarController()
        let navC = UINavigationController(rootViewController: tabBarC)
        
        // Allocate resultVC's
        let movieResultsVC = ResultsViewController()
        movieResultsVC.presenter = MovieResultsPresenter(view: movieResultsVC)
        movieResultsVC.title = "Movies"
        
        tabBarC.setViewControllers([movieResultsVC], animated: false)
        
        // Configure style
        navC.navigationBar.barStyle = .black
        tabBarC.tabBar.barStyle = .black
        
        // Set window's root and make visible
        window!.rootViewController = navC
        window!.makeKeyAndVisible()
        
        return true
    }
}

