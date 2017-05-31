//
//  ResultsViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 30/05/2017.
//
//

import UIKit

class ResultsViewController: UIViewController {

    
    // MARK: - Properties
    
    var modelType: ModelType!
    lazy fileprivate var resultsDataSource: ResultsDataSource = {
        return ResultsDataSource(modelType: self.modelType)
    }()
    @IBOutlet var collectionView: UICollectionView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        navigationItem.title = "MVC"
        
        // CollectionView
        collectionView.dataSource = resultsDataSource
        collectionView.delegate = self
        
        fetchNewObjects()
    }
    
    private func fetchNewObjects() {
        // Fetch on background thread, dispatched on main:
        DataManager.shared.fetchNewTmdbObjects(withType: modelType) { (result) in
            switch result {
            case let .success(parsables):
                self.resultsDataSource.modelObjects = parsables
            case let .failure(error):
                print(error)
                self.resultsDataSource.modelObjects.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
}


// MARK: - CollectionView Delegate

extension ResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Instantiate and push detailVC
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailVC.modelObject = resultsDataSource.modelObjects[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension ResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Half screen width with room for 1pt interitemspacing
        let widthDivisor: CGFloat = modelType == .movie ? 2 : 3
        let heightDivisor: CGFloat = modelType == .movie ? 2.5 : 3
        let spacing: CGFloat = modelType == .movie ? 1 : 8
        
        // Calculate itemSize
        let fullWspace = (widthDivisor + 1) * spacing
        let fullHspace = (heightDivisor + 1) * spacing
        let width = (view.bounds.width - fullWspace) / widthDivisor
        let height = (view.bounds.height - fullHspace) / heightDivisor
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return modelType == .movie ? 1 : 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return modelType == .movie ? 1 : 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing: CGFloat = modelType == .movie ? 1 : 8
        return UIEdgeInsets(top: spacing, left: spacing, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: spacing)
    }
}
