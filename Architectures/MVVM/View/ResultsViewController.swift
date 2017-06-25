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

final class ResultsViewController: UIViewController {

    
    // MARK: - Properties
    
    var viewModel: ViewModelInterface!
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout(abstraction: self.viewModel, bounds: self.view.bounds))
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
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        tabBarController?.navigationItem.title = "MVVM"
        view.backgroundColor = .black
        view.addSubview(collectionView)
        
        // Bind
        viewModel.bindViewReload { [weak self] in
            self?.collectionView.reloadSections(IndexSet(integer: 0))
        }
        // Invoke
        viewModel.fetchNewModelObjects()
    }

    func showDetail(with imageUrl: URL, navigationTitle: String) {
        let vc = DetailViewController()
        vc.navigationItem.title = navigationTitle
        vc.imageURL = imageUrl
        show(vc, sender: viewModel)
    }
}


// MARK: - CollectionView Delegate

/*
    - user selects cell
    - call showDetail on view model with index path
    - view model decides which model to use, and calls the bound closure
*/
extension ResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Bind
        viewModel.bindPresentation { [weak self] (url, title) in
            self?.showDetail(with: url, navigationTitle: title)
        }
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
        if let cellConfigurable = cell as? CellConfigurable {
            // Subscript: viewModel[i] -> PresentableInstance<Transportable>
            cellConfigurable.configure(with: viewModel[indexPath.row])
        }
        return cell
    }
}
