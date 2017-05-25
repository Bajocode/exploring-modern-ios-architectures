//
//  ResultsViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//
/*
    No XIB needed: improves modularity when dealing with very basic VC's
*/

import UIKit

class ResultsViewController: UIViewController {

    
    // MARK: - Properties
    
    var viewModel: ViewModel!
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout(viewModel: self.viewModel))
        let movieCellNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        cv.register(movieCellNib, forCellWithReuseIdentifier: "MovieCell")
        cv.dataSource = self
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: - Methods
    
    func configure() {
        view.addSubview(collectionView)
        
        // Bind ViewModel data updates to collectionView refresh
        viewModel.bind { [weak self] in
            self?.collectionView.reloadSections(IndexSet(integer: 0))
        }
        
        // Offload data reloading to viewModel
        viewModel.fetchNewModelObjects()
    }
}


// MARK: - CollectionView DataSource

extension ResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellID, for: indexPath) as! MovieCollectionViewCell
        return cell
    }
}
