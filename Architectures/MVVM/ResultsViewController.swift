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
    var data = [CellRepresentable]()
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
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return data[indexPath.row].cellInstance(collectionView, indexPath: indexPath)
    }
}


// MARK: - CollectionViewDelegateFlowLayout

extension ResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard !data.isEmpty else {
            return CGSize.zero
        }
        let proportion = data[indexPath.item].cellProportion
        let width = (view.bounds.width - proportion.spacing) / proportion.widthDivisor
        let height = (view.bounds.height - proportion.spacing) / proportion.heightDivisor
        
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard !data.isEmpty else {
            return 0.0
        }
        return data[section].cellProportion.spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard !data.isEmpty else {
            return 0.0
        }
        return data[section].cellProportion.spacing
    }
}
