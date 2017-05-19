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
            collectionView.reloadData()
        }
    }
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


// MARK: - CollectionView Delegate

extension ResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let vm = data[indexPath.item]
        DataManager.shared.imageManager.fetchImage(forVM: vm, size: .thumb) { result in
   
            // Make sure that we are dealing with same movie object (fetching takes time)
            guard
                let vmIndex = self.data.index(where: { $0.objectID == vm.objectID }),
                case let.success(image) = result else {
                    return
            }
            let movieIndexPath = IndexPath(row: vmIndex, section: 0)
            
            // Update cell when image request finishes, if cell still visible on screen
            if let cell = self.collectionView.cellForItem(at: movieIndexPath) as? MovieCollectionViewCell {
                cell.updateImageView(with: image)
            }
            
        }
        
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
