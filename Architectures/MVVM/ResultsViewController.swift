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
    var data = [CellRepresentable]() {
        didSet {
            collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    // MARK: - Methods
    
    private func setUp() {
        // Configure collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
       
        // Register cells
        let movieCellNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(movieCellNib, forCellWithReuseIdentifier: "MovieCell")
        let actorCellNib = UINib(nibName: "ActorCollectionViewCell", bundle: nil)
        collectionView.register(actorCellNib, forCellWithReuseIdentifier: "ActorCell")
    }
}


// MARK: - CollectionView DataSource

extension ResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return data[indexPath.item].cellInstance(collectionView, indexPath: indexPath)
    }
}


// MARK: - CollectionView Delegate

extension ResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Download the image data for only the cells that the user is attempting to view.
        data[indexPath.item].updateCellImage(collectionView, cell: cell, indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel = data[indexPath.item] as! DetailRepresentable
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


// MARK: - CollectionViewDelegateFlowLayout

extension ResultsViewController: UICollectionViewDelegateFlowLayout {
    // Size is dynamic, spacing is set in Xib
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return data.isEmpty ? CGSize.zero : data[indexPath.item].cellSize(withBounds: view.bounds)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return data.isEmpty ? 0.0 : data[section].cellSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return data.isEmpty ? 0.0 : data[section].cellSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return data.isEmpty ? UIEdgeInsets.zero : data[section].collecitonViewInsets(with: tabBarController!.tabBar.bounds.height)
    }
}
