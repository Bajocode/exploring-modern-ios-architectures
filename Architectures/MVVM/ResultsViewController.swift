//
//  ResultsViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

class ResultsViewController: UIViewController {


    // MARK: - Properties
    
    @IBOutlet var collectionView: UICollectionView!
    let cellID = "MovieCell"
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register cell
        let movieCellNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(movieCellNib, forCellWithReuseIdentifier: cellID)
    }
    
    
    // MARK: - Methods
    
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Navigation
}


// MARK: - CollectionView DataSource

extension ResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
}
extension ResultsViewController: UICollectionViewDelegate {
    
}
