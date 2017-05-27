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
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout(viewModel: self.viewModel, bounds: self.view.bounds))
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
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        view.backgroundColor = .black
        view.addSubview(collectionView)
        
        // Bind
        viewModel.bindModelUpdate(with: { [weak self] in
            self?.collectionView.reloadSections(IndexSet(integer: 0))
        })
        // Invoke
        viewModel.fetchNewModelObjects()
    }

    func showDetail(with url: URL) {
        let vc = DetailViewController()
        vc.imageURL = url
        show(vc, sender: viewModel)
    }
}


// MARK: - CollectionView Delegate

extension ResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Bind
        viewModel.bindPresentation { [weak self] (url) in
            self?.showDetail(with: url)
        }
        // Invoke
        viewModel.showDetail(at: indexPath)
    }
}

// MARK: - CollectionView DataSource

extension ResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellID, for: indexPath)
        if let imagePresentable = cell as? CellConfigurable {
            // Subscript: viewModel[i] -> PresentableInstance<Parsable>
            imagePresentable.configure(with: viewModel[indexPath.row])
        }
        return cell
    }
}
