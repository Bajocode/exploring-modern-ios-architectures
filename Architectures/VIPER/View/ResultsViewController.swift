//
//  ResultsViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 31/05/2017.
//
//

import UIKit

class ResultsViewController: UIViewController, ResultsViewInterface {
    
    
    // MARK: - Properties
    
    var presenter: ResultsPresenterInterface!
    fileprivate var presentableObjects = [Transportable]()
    fileprivate lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout(abstraction: self.presenter.collectionConfiguration(), bounds: self.view.bounds))
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
        configure()
        // Interactor fetches new presentable objects
        presenter.updateView()
    }
    
    
    // MARK: - Methods
    
    // ResultsViewInterface
    func update(presentableObjects: [Transportable]) {
        self.presentableObjects = presentableObjects
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    private func configure() {
        self.view.addSubview(collectionView)
    }
}


// MARK: - CollectionView Delegate

extension ResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetail(forPresentable: presentableObjects[indexPath.row])
    }
}


// MARK: - CollectionView DataSource

extension ResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presentableObjects.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: presenter.collectionConfiguration().cellID, for: indexPath)
        if let cellConfigurable = cell as? CellConfigurable {
            cellConfigurable.configure(with: presentableObjects[indexPath.row])
        }
        return cell
    }
}
