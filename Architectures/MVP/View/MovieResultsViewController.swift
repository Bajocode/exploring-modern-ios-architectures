//
//  MovieResultsViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 29/05/2017.
//
//

import UIKit

class MovieResultsViewController: UIViewController, ResultsView {

    
    // MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout(allSpacingEqualFor: self.viewModel, bounds: self.view.bounds))
        cv.clipsToBounds = true
        let movieCellNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        cv.register(movieCellNib, forCellWithReuseIdentifier: "MovieCell")
        let actorCellNib = UINib(nibName: "ActorCollectionViewCell", bundle: nil)
        cv.register(actorCellNib, forCellWithReuseIdentifier: "ActorCell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    // MARK: - Methods
    
    
    func reloadCollectionData() {
        <#code#>
    }
}
