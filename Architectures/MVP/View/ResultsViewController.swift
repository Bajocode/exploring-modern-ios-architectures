//
//  ResultsViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 29/05/2017.
//
//

import UIKit

class ResultsViewController: UIViewController, ResultsView {
    
    
    // MARK: - Properties
    
    var presenter: ResultsViewPresenter!
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout(abstraction: self.presenter, bounds: self.view.bounds))
        cv.clipsToBounds = true
        let movieCellNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        cv.register(movieCellNib, forCellWithReuseIdentifier: "MovieCell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter.presentNewObjects()
    }

    
    // MARK: - Methods
    
    private func configure() {
        tabBarController?.navigationItem.title = "MVP"
        view.backgroundColor = .black
        view.addSubview(collectionView)
    }
    
    func reloadCollectionData() {
        collectionView.reloadData()
    }
}

extension ResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
}

// MARK: - CollectionView DataSource

extension ResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.objectsCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: presenter.cellID, for: indexPath)
        if let cellConfigurable = cell as? CellConfigurable {
            // Subscript: viewModel[i] -> PresentableInstance<Parsable>
            cellConfigurable.configure(with: presenter.presentableInstance(index: indexPath.row))
        }
        return cell
    }
}
