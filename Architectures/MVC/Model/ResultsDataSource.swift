//
//  ResultsDataSource.swift
//  Architectures
//
//  Created by Fabijan Bajo on 30/05/2017.
//
//

import UIKit

class ResultsDataSource: NSObject, UICollectionViewDataSource {
    
    
    // MARK: - Initializers
    
    convenience init(modelType: ModelType) {
        self.init()
        cellID = modelType == .movie ? "MovieCell" : "ActorCell"
    }

    
    // MARK: - Properties
    
    var modelObjects = [Transportable]()
    private var cellID: String!
    
    
    // MARK: - CollectionView Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelObjects.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        if let configurable = cell as? CellConfigurable {
            configurable.configure(with: modelObjects[indexPath.row])
        }
        return cell
    }
}
